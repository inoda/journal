class SessionsController < ApplicationController
  skip_before_action :require_logged_in, only: [:new, :create]

  def new
    redirect_to posts_path if logged_in
  end

  def create
    if AuthManager.authenticate(params[:username], params[:password])
      begin
        ApplicationMailer.send_login_alert(request.remote_ip).deliver
      rescue
        Rails.logger.error "Failed to send login alert"
      end

      session[:logged_in] = true
    else
      flash[:error] = "Incorrect login"
    end

    redirect_to :root
  end

  def destroy
    session[:logged_in] = false
    redirect_to :root
  end
end
