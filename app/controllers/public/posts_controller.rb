class Public::PostsController < ApplicationController
  
  def new_guest
    # emailでユーザーが見つからなければ作ってくれるという便利なメソッド
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
    # 自分はユーザー登録時にニックネームを必須にしているのでこの記述が必要
    user.nickname = "ゲスト"
    # 英数字混合を必須にしているので、ランダムパスワードに、英字と数字を追加してバリデーションに引っかからないようにしています。
    user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    user.confirmed_at = Time.now
    end
    # sign_inはログイン状態にするデバイスのメソッド、userは3行目の変数userです。
    sign_in user
    # ログイン後root_pathに飛ぶようにしました。
    redirect_to root_path
  end

  def index
    # @posts = Post.page(params[:page])
    @posts = Post.all
    @total_post = Post.count
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
end
