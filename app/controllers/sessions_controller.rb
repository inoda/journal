class SessionsController < ApplicationController
  skip_before_action :require_logged_in, only: [:new, :create]

  def new
    redirect_to posts_path if logged_in
  end

  def create
    if params[:username] == ENV['USERNAME'] && params[:password] == ENV['PASSWORD']
      session[:logged_in] = true
    end

    redirect_to :root
  end

  def destroy
    session[:logged_in] = false
    redirect_to :root
  end
end
