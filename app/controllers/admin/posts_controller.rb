class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
    @comments = @post.comments # コメント一覧表示用
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
