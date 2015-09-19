class PostsController < ApplicationController

  before_filter :require_correct_author, only: [:edit, :update, :destroy]

  def show
    @post = Post.includes(:author,:comments).find(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.new(author_id: current_user.id)
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      flash[:success] = ["Made Post"]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = ["Updated Post"]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to sub_url(@post.sub_id)
    else
      redirect_to post_url(@post.id), status: 404
    end

  end


  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_correct_author
    @post = Post.find(params[:id])
    redirect_to sub_url(@post.sub_id) unless current_user.id == @post.author_id
  end
end
