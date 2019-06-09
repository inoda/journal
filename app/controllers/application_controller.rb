class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :require_logged_in

  def require_logged_in
    redirect_to root_path and return if !session[:logged_in]
  end

  def ensure_sane_page
    return if !params[:page]
    params[:page] = 1 if params[:page].to_i < 1 || params[:page].to_i > 999999999999999999
  end
end
