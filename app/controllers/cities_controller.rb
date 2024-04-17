class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index ]
  skip_before_action :authorize_user!, only: %i[ index ]
  def index
    @department = Department.find(params[:department_id])
    @cities = @department.cities
    render json: @cities
  end
end
