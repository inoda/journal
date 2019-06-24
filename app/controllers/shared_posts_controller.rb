class SharedPostsController < ApplicationController
  skip_before_action :require_logged_in, only: [:show]

  def show
    @post = Post.find_by_sharing_token(Post.encrypted_sharing_token(params[:id]))

    if !@post
      flash[:error] = "Invalid link"
      redirect_to root_path and return
    end
  end
end
