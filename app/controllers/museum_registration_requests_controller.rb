class MuseumRegistrationRequestsController < ApplicationController
  prepend_before_action :set_museum_registration_request, only: %i[ show update ]
  skip_before_action :authenticate_user!, only: %i[ new create cities ]
  skip_before_action :authorize_user!, only: %i[ new create cities ]
  before_action :set_department_city, only: :new

  # GET /museum_registration_requests or /museum_registration_requests.json
  def index
    # to-do: should review logic for showing or hiding items
    @q = MuseumRegistrationRequest.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @pagy, @museum_registration_requests = pagy(@q.result)
  end

  # GET /museum_registration_requests/1 or /museum_registration_requests/1.json
  def show
  end

  # GET /museum_registration_requests/new
  def new
    @museum_registration_request = MuseumRegistrationRequest.new
  end

  # POST /museum_registration_requests or /museum_registration_requests.json
  def create
    @museum_registration_request = MuseumRegistrationRequest.new(museum_registration_request_params)

    if current_user
      @museum_registration_request.created_by = current_user
      @museum_registration_request.manager_email = current_user.email
      @museum_registration_request.first_name = current_user.first_name
      @museum_registration_request.last_name = current_user.last_name
      @museum_registration_request.ci = current_user.ci
      @museum_registration_request.phone_number = current_user.phone_number
    end

    respond_to do |format|
      if @museum_registration_request.save
        format.html { redirect_to root_path, notice: t(".success") }
        notify_new_request
      else
        set_department_city
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @museum_registration_request.update(museum_registration_request_params)
      redirect_to museum_registration_request_url(@museum_registration_request), notice: t(".success")
      notify_updated_request
    else
      render :show, status: :unprocessable_entity
    end
  end

  def cities
    # set a "target" this will contain the id of the html tag we want to update
    # this function will be connected with cities.turbo_stream.erb passing the @target and @cities attributes
    @target = params[:target]
    @department = Department.find(params[:department])
    @cities = @department.cities.order(:name).map { |city| [city.name, city.id] }
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_museum_registration_request
    @museum_registration_request = MuseumRegistrationRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def museum_registration_request_params
    attributes = params
                   .require(:museum_registration_request)
                   .permit([
                             :museum_name,
                             :museum_code,
                             :museum_address,
                             :manager_email,
                             :registration_status,
                             :department_id,
                             :city_id,
                             :registration_doc,
                             :first_name,
                             :last_name,
                             :ci,
                             :phone_number,
                             :feedback
                           ])
    attributes[:registration_status] = attributes[:registration_status].to_i
    attributes[:updated_by] = current_user
    attributes
  end

  def get_archived
    @museum_registration_requests = MuseumRegistrationRequest.where(registration_status: MuseumRegistrationRequest::ARCHIVED)
  end

  def notify_new_request
    UserMailer.with(museum_registration_request: @museum_registration_request).new_museum_registration_request.deliver_later
    UserMailer.with(museum_registration_request: @museum_registration_request).new_museum_registration_request_user.deliver_later
  rescue StandardError
    flash.now[:alert] = "Algo salió mal con la notificación de creación!"
  end

  def notify_updated_request
    if @museum_registration_request.approved?
      UserMailer.with(museum_registration_request: @museum_registration_request).approved_museum_registration_request.deliver_later
    elsif @museum_registration_request.rejected?
      UserMailer.with(museum_registration_request: @museum_registration_request).rejected_museum_registration_request.deliver_later
    end
  rescue StandardError
    flash.now[:alert] = "Algo salió mal con la notificación de actualización!"

  end

  def set_department_city
    @cities = City.all
    @departments = Department.order(:name).map { |department| [department.name, department.id] }
  end

  def authorize_user!
    not_authorized unless current_user.admin?
  end
end
