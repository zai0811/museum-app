class MuseumsController < ApplicationController
  before_action :set_museum, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[ index show ]
  skip_before_action :authorize_user!, only: %i[ index show ]

  # GET /museums or /museums.json
  def index
    @museums = Museum.all
  end

  # GET /museums/1 or /museums/1.json
  def show
  end

  # GET /museums/new
  def new
    @museum = Museum.new
  end

  # GET /museums/1/edit
  def edit
  end

  # POST /museums or /museums.json
  def create
    @museum = Museum.new(museum_params)
    @museum.user = current_user

    respond_to do |format|
      if @museum.save
        format.html { redirect_to museum_url(@museum), notice: "Museum was successfully created." }
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
        format.html { redirect_to museum_url(@museum), notice: "Museum was successfully updated." }
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
      format.html { redirect_to museums_url, notice: "Museum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_museums

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_museum
    @museum = Museum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def museum_params
    params.require(:museum).permit(:name, :code, :about, :email, :phone, :page, :address, :user_id)
  end

  def authorize_user!
    authorized = case action_name
                 when "new" then current_user.admin?
                 when "create" then current_user.admin?
                 when "update" then current_user.owner_or_admin?(@museum)
                 when "edit" then current_user.owner_or_admin?(@museum)
                 when "destroy" then current_user.admin?
                 else
                   false
                 end

    not_authorized  unless authorized
  end

end
