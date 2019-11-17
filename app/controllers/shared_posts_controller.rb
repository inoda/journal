class SharedPostsController < ApplicationController
  layout "layouts/public"
  skip_before_action :require_logged_in, only: [:show, :index]

  def index
    @posts_exist = Post.where.not(sharing_token: nil).where(listed_publicly: true).count > 0
    @posts = Post.where.not(sharing_token: nil).where(listed_publicly: true).order(created_at: :desc).paginate(params[:page])
  end

  def show
    @post = Post.find_by_sharing_token(Post.encrypted_sharing_token(params[:id]))

    if !@post
      flash[:error] = "Invalid link"
      redirect_to shared_posts_path and return
    end
  end
end
