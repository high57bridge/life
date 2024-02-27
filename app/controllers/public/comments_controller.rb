class Public::CommentsController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
       @post = Post.find(params[:post_id])
       @comment = Comment.find(params[:id])
       @comment.customer_id = current_customer.id
    if @comment.update(comment_params)
       redirect_to public_post_path(@post), notice: '編集しました'
    else
      flash.now[:alert] = '編集に失敗しました'
      render "public/posts/show"
    end
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
    params.require(:comment).permit(:customer_id, :post_id, :comment)
  end
end
