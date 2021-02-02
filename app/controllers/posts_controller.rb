class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :show, :update, :destroy, :share, :unshare]

  def index
    @posts_exist = Post.count > 0
    posts = Post.all.order(created_at: :desc)
    posts = posts.where.not(sharing_token: nil) if params[:only_shared]
    @posts = posts.paginate(params[:page])
  end

  def new
    autosave = Autosave.first
    @random_prompt = Prompt.random
    @post = Post.new(content: autosave&.decrypted_content, title: autosave&.decrypted_title)
  end

  def edit
  end

  def show
  end

  def autosave
    Autosave.first_or_create.update!(
      title: params[:title],
      content: params[:content]
    )

    head :ok
  end

  def create
    @post = PostManager.create(params[:title], params[:content])

    if !@post.new_record?
      Autosave.first&.destroy
      flash[:success] = "Entry saved"
      redirect_to posts_path
    else
      flash.now[:error] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    if PostManager.update(@post, params[:title], params[:content])
      flash[:success] = "Entry saved"
      redirect_to post_path(@post)
    else
      flash.now[:error] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Entry deleted"
    else
      flash[:error] = "Issue deleting entry"
    end

    redirect_to posts_path
  end

  def share
    public = params[:public] == true.to_s

    if PostManager.share(@post, public)
      flash[:success] = public ? "Entry is now available publicly" : "Secret link has been generated."
    else
      flash[:error] = public ? "Issue posting entry publicly" : "Issue generating a secret link"
    end

    redirect_to post_path(@post)
  end

  def unshare
    if PostManager.unshare(@post)
      flash[:success] = "All shared access to entry has been revoked"
    else
      flash[:error] = "Issue unsharing"
    end

    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])

    if !@post
      flash[:error] = "Entry is missing"
      redirect_to posts_path and return
    end
  end
end
