class SharedPostsController < ApplicationController
  layout "layouts/public"
  skip_before_action :require_logged_in, only: [:show, :index]

  def index
    @posts = Post.where.not(sharing_token: nil).where(listed_publicly: true).order(created_at: :desc).has_tag(params[:search]).paginate(params[:page])
  end

  def show
    @post = Post.find_by_sharing_token(Post.encrypted_sharing_token(params[:id]))

    if !@post
      flash[:error] = "Invalid link"
      redirect_to root_path and return
    end
  end
end
