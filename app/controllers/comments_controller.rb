class CommentsController < ApplicationController
  def show
    @comment = Comment.includes(:author).find(params[:id])
  end
  def new

  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    redirect_to post_url(@comment.post_id)
  end
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
