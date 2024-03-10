class Post < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  
  has_many :comments, dependent: :destroy  # Post.comments で、その投稿のコメント取得
  has_many :replies, class_name: "Comment", foreign_key: :reply_comment, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  def liked_by?(customer)
    likes.exists?(customer_id: customer)
  end
  
  has_many :reads, dependent: :destroy
  
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
