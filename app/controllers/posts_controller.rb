class PostsController < ApplicationController
  before_action :require_login
  before_action :only_author_can_do, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:sub_id])
  end

  def update
    @post = Post.find_by(params[:sub][:title])
    if @post
      @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:sub_id])
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = current_sub.id
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def only_author_can_do
    if current_user.posts.find_by(:id, params[:id])
      true
    else
      render 'you cant edit this post'
    end
  end
end
