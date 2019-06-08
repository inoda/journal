class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :require_logged_in

  def require_logged_in
    redirect_to root_path and return if !session[:logged_in]
  end
end
