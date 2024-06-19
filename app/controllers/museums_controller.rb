class MuseumsController < ApplicationController
  before_action :set_museum, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[ index show ]
  skip_before_action :authorize_user!, only: %i[ index show edit update ]

  # GET /museums or /museums.json
  def index
    @q = Museum.ransack(params[:q])
    @museums = @q.result(distinct: true)
  end

  # GET /museums/1 or /museums/1.json
  def show
    @piece_collections = @museum.piece_collections
  end

  # GET /museums/new
  def new
    @museum = Museum.new
  end

  # GET /museums/1/edit
  def edit
    # Need to add authorize user here becuase the before_action that comes from the action controller is
    # executed before the set_museum so the method becomes authorize_user!(nil) = false
    authorize_user!
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
    authorize_user!

    respond_to do |format|
      if @museum.update(museum_params)
        format.html { redirect_to museum_url(@museum), notice: t(".success") }
        format.json { render :show, status: :ok, location: @museum }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    @museum = Museum.find(params[:id])
    status = params[:status].to_i

    begin
      message = @museum.update_status!(status) ?
                  t(".success") : t(".error")
      redirect_to @museum, notice: message

      # TODO handle exceptions with custom class
    rescue StandardError => e
      redirect_to @museum, alert: e.message
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_museum
    @museum = Museum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def museum_params
    params.require(:museum).permit(:name, :code, :about, :email, :phone, :page, :address, :user_id, :department, :city, :status)
  end

  def authorize_user!
    authorized = case action_name
                 when "new", "create", "destroy" then current_user.admin?
                 when "update", "edit", "update_museum_status" then current_user.admin_or_museum_owner?(@museum)
                 else
                   false
                 end

    not_authorized unless authorized
  end

end
