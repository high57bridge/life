class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ投稿を表示するため
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
    @comments = @post.comments # コメント一覧表示用
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice]= "投稿に成功しました"
      redirect_to admin_post_path(@post)
    else
      @posts = Post.all
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
       @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice]= "投稿の更新に成功しました"
       redirect_to admin_post_path
    else
      flash.now[:alert] = "投稿の更新に失敗しました"
      render :edit
    end
  end

  def destroy
       @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice]= "投稿を削除しました"
      redirect_to admin_posts_path
    else
      flash.now[:alert] = "投稿を削除できませんでした"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :address, :image)
  end
end
