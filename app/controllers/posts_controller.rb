class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destroy]
  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "New post created"
      else
        render :new
      end
    end
  end
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end
  def show
  end
  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to post_path, notice: "Post update with sucess"
    else
      render :edit
    end
  end
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post delete with sucess"
  end
  private
  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
