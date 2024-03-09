class Post < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  
  has_many :comments, dependent: :destroy  # Post.comments で、その投稿のコメント取得
  has_many :replies, class_name: "Comment", foreign_key: :reply_comment, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  def liked_by?(customer)
    likes.exists?(customer_id: customer)
  end
  
  has_many :notifications, dependent: :destroy
  
  def create_notification_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        post_id: id,
        visited_id: customer_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  has_many :hashtags, dependent: :destroy
  has_many :tags, through: :hashtags
  
  after_create do
    post = Post.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    tags = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end
  #更新アクション
  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    tags = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      post.tags << tag
    end
  end

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE? or introduction LIKE? or address LIKE?","%#{word}%", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
