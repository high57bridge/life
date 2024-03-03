class Admin::CommentsController < ApplicationController

def destroy
     @post = Post.find(params[:post_id])
     @comment = Comment.find(params[:id])
  if @comment.destroy
     redirect_to admin_post_path(@post), notice: 'コメントを削除しました'
  else
    flash.now[:alert] = 'コメント削除に失敗しました'
    render "admin/posts/show"
  end
end

end
