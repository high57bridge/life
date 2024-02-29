class Public::PostsController < ApplicationController

  def new_guest
    # emailでユーザーが見つからなければ作ってくれるという便利なメソッド
    customer = Customer.find_or_create_by(email: 'guest@example.com') do |customer|
    # 自分はユーザー登録時にニックネームを必須にしているのでこの記述が必要
    customer.nickname = "ゲスト"
    # 英数字混合を必須にしているので、ランダムパスワードに、英字と数字を追加してバリデーションに引っかからないようにしています。
    customer.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    customer.confirmed_at = Time.now
    end
    # sign_inはログイン状態にするデバイスのメソッド、customerは3行目の変数customerです。
    sign_in customer
    # ログイン後root_pathに飛ぶようにしました。
    redirect_to root_path
  end

  def index
       @posts = Post.page(params[:page]).per(5)
       @tag_lists = Tag.all
       @total_post = Post.count   # 何件投稿されているか確認するため
    if params[:search].present?   #検索フォームに入力があった場合
      @posts = Post.posts_serach(params[:search])
    elsif params[:tag_id].present?   #paramsで:tag_idを受け取った場合（クリックしたときにパラメータでtag_idを受け取ったときに発動する。タグで絞込む機能）
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)   #普通にページを表示させた場合
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
  end

  def new
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
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def tag
    @customer = current_customer
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts
  end

end
