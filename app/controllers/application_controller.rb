class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorize_user!
  include Pagy::Backend

  def not_authorized
    flash[:alert] = I18n.t("global.errors.messages.unauthorized")
    redirect_back(fallback_location: root_path)
  end

  private

  def authorize_user!
    false
  end
end
