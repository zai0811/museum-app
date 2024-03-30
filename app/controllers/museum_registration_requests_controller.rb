class MuseumRegistrationRequestsController < ApplicationController
  before_action :set_museum_registration_request, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[ new create ]
  skip_before_action :authorize_user!, only: %i[ new create ]

  # GET /museum_registration_requests or /museum_registration_requests.json
  def index
    @museum_registration_requests = MuseumRegistrationRequest.all
  end

  # GET /museum_registration_requests/1 or /museum_registration_requests/1.json
  def show
  end

  # GET /museum_registration_requests/new
  def new
    @museum_registration_request = MuseumRegistrationRequest.new
  end

  # GET /museum_registration_requests/1/edit
  def edit
  end

  # POST /museum_registration_requests or /museum_registration_requests.json
  def create
    @museum_registration_request = MuseumRegistrationRequest.new(museum_registration_request_params)

    respond_to do |format|
      if @museum_registration_request.save
        format.html { redirect_to root_path, notice: "Museum registration request was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /museum_registration_requests/1 or /museum_registration_requests/1.json
  def update
    respond_to do |format|
      if @museum_registration_request.update(museum_registration_request_params)
        format.html { redirect_to museum_registration_request_url(@museum_registration_request), notice: "Museum registration request was successfully updated." }
        format.json { render :show, status: :ok, location: @museum_registration_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @museum_registration_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /museum_registration_requests/1 or /museum_registration_requests/1.json
  def destroy
    @museum_registration_request.destroy!

    respond_to do |format|
      format.html { redirect_to museum_registration_requests_url, notice: "Museum registration request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_registration_status
    @museum_registration_request = MuseumRegistrationRequest.find(params[:id])
    status = params[:registration_status].to_i

    begin
      message = @museum_registration_request.update_registration_status!(status) ? "Se actualizó el estado correctamente." : "Estado inválido."
      redirect_to @museum_registration_request, notice: message

    rescue StandardError => e # todo add more classes
      redirect_to @museum_registration_request, alert: e.message
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_museum_registration_request
    @museum_registration_request = MuseumRegistrationRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def museum_registration_request_params
    params.require(:museum_registration_request).permit(:museum_name, :museum_code, :museum_address, :manager_email, :manager_name)
  end

  def authorize_user!
    authorized = current_user.admin?
    not_authorized  unless authorized
  end
end
