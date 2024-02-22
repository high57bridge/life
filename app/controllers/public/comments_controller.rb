class Public::CommentsController < ApplicationController
  
  def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to public_post_path(@post) notice: 'コメントしました'
    else
      flash.now[:alert] = 'コメントに失敗しました'
      render public_post_path(@post)
    end
  end
  
  def destroy
       @post = Post.find(params[:post_id])
       @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to public_post_path(@post), notice: 'コメントを削除しました'
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      render public_post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :customer_id, :comment)
  end
  
end
