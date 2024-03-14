class MuseumRegistrationRequestsController < ApplicationController
  before_action :set_museum_registration_request, only: %i[ show edit update destroy ]

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
        format.html { redirect_to museum_registration_request_url(@museum_registration_request), notice: "Museum registration request was successfully created." }
        format.json { render :show, status: :created, location: @museum_registration_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @museum_registration_request.errors, status: :unprocessable_entity }
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
    @museum_registration_request.update!(registration_status: params[:registration_status])

    if params[:registration_status] == "approved"
      @museum = @museum_registration_request.accept_registration_request
      redirect_to museum_url(@museum), notice: "Solicitud approbada! Nuevo museo creado: #{@museum.name}."
    else
      redirect_to @museum_registration_request, notice: "El estado de la Solicitud de registro cambió a: #{@museum_registration_request.registration_status}."
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
end
