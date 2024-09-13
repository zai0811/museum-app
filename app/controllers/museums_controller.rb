class MuseumsController < ApplicationController
  prepend_before_action :set_museum, only: %i[ show edit update destroy update_museum_status]
  skip_before_action :authenticate_user!, only: %i[ index show coordinates ]
  skip_before_action :authorize_user!, only: %i[ index show coordinates ]

  # GET /museums or /museums.json
  def index
    @archived_museums = Museum.where(status: Museum::ARCHIVED)
    @q = Museum.ransack(params[:q])
    @pagy, @museums = pagy(@q.result.includes(:city, :user))
  end

  # GET /museums/1 or /museums/1.json
  def show
    @q = PieceCollection
           .where(museum_id: @museum.id, status: [PieceCollection::NOT_PUBLISHED, PieceCollection::PUBLISHED])
           .ransack(params[:q])
    @pagy, @piece_collections = pagy(@q.result, limit: 5)
  end

  # GET /museums/new
  def new
    @museum = Museum.new
  end

  # GET /museums/1/edit
  def edit
    @departments = Department.order(:name).map { |department| [department.name, department.id] }
    @cities = @museum.city ? @museum.department.cities.order(:name).map { |city| [city.name, city.id] } : []
  end

  # POST /museums or /museums.json
  def create
    @museum = Museum.new(museum_params)
    @museum.user = current_user

    respond_to do |format|
      if @museum.save
        format.html { redirect_to museum_url(@museum), notice: t(".success") }
        format.json { render :show, status: :created, location: @museum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /museums/1 or /museums/1.json
  def update
    respond_to do |format|
      if @museum.update(museum_params)
        format.html { redirect_to museum_url(@museum), notice: t(".success") }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @museum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /museums/1 or /museums/1.json
  def destroy
    @museum.destroy!
    respond_to do |format|
      format.html { redirect_to museums_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  def update_museum_status
    status = params[:status].to_i

    begin
      message = @museum.update_status!(status) ?
                  t(".success") : t(".error")
      redirect_back_or_to @museum, notice: message

      # TODO handle exceptions with custom class
    rescue StandardError => e
      redirect_to @museum, alert: e.message
    end
  end

  def coordinates
    @museums = Museum.published
    render formats: :json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_museum
    @museum = Museum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def museum_params
    attributes = params
                   .require(:museum)
                   .permit([
                             :name,
                             :code,
                             :about,
                             :email,
                             :phone,
                             :page,
                             :address,
                             :user_id,
                             :department,
                             :city,
                             :department_id,
                             :city_id,
                             :status,
                             :image,
                             :latitude,
                             :longitude
                           ])
    attributes[:status] = attributes[:status].to_i
    attributes
  end

  def authorize_user!
    authorized = case action_name
                 when "new", "create", "destroy" then current_user.admin?
                 when "update", "edit", "update_museum_status"
                 then current_user.admin_or_museum_owner?(@museum)
                 else
                   false
                 end

    not_authorized unless authorized
  end

end
