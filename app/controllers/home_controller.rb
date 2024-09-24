class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authorize_user!
  def index
    @q = Museum.where(status: [Museum::PUBLISHED]).ransack(params[:q])
    @museums = @q.result(distinct: true)
  end
end
