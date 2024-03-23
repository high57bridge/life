class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def index
       @posts = Post.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ投稿を表示するため
       @tag_lists = Tag.all
       @total_post = Post.count   # 何件投稿されているか確認するため
    if params[:search].present?   #検索フォームに入力があった場合
      @posts = Post.posts_serach(params[:search])
    elsif params[:tag_id].present?   #paramsで:tag_idを受け取った場合（クリックしたときにパラメータでtag_idを受け取ったときに発動する。タグで絞込む機能）
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)   #普通にページを表示させた場合
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
    @comment_reply = @post.comments.build   #コメントに対する返信用の変数
    @comments = Comment.includes(:customer).where(post_id: @post.id)
    Read.create(post_id: @post.id, customer_id: current_customer.id, complete: true)
  end

  def new
    @posts = Post.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ投稿を表示するため
    @total_post = Post.count   # 何件投稿されているか確認するため
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:name].split(nil)
    @post.image.attach(params[:post][:image])
    @post.customer_id = current_customer.id
    if @post.save
      @post.save_posts(tag_list)
      redirect_to public_post_tags_path
    else
      render :new
    end
  end

end
