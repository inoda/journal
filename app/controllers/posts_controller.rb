class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by_id(params[:id])

    if !@post
      flash[:error] = "Issue loading post for edit"
      redirect_to posts_path and return
    end
  end

  def show
    @post = Post.find_by_id(params[:id])

    if !@post
      flash[:error] = "Issue loading post for edit"
      redirect_to posts_path and return
    end
  end

  def create
    @post = Post.new(title: params[:title], content: params[:content])

    if @post.save
      flash[:success] = "Entry saved"
      redirect_to posts_path
    else
      flash.now[:error] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(title: params[:title], content: params[:content])
      flash[:success] = "Entry saved"
      redirect_to post_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    post = Post.find_by_id(params[:id])

    if post && post.delete
      flash[:success] = "Entry deleted"
    else
      flash[:error] = "Issue deleting entry"
    end

    redirect_to posts_path
  end
end
