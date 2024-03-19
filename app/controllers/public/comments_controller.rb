class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def update
    @comment = current_customer.comments.find(params[:id])
    @comment.reload unless @comment.update(comment_params)
    @post = @comment.post
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.customer_id = current_customer.id
    if @comment.save
      redirect_to public_post_path(@post), notice: 'コメントしました'
    else
      flash.now[:alert] = 'コメントに失敗しました'
      render "public/posts/show"
    end
  end

  def destroy
       @post = Post.find(params[:post_id])
       @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to public_post_path(@post), notice: 'コメントを削除しました'
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      render "public/posts/show"
    end
  end
  
private

  def comment_params
    params.require(:comment).permit(:customer_id, :post_id, :reply_comment, :comment)
  end
end
