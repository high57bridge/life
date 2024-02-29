class Post < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  
  has_many :comments, dependent: :destroy  # Post.comments で、その投稿のコメント取得
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
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

  
  #検索メソッド、タイトルと内容をあいまい検索する
  # def self.posts_serach(search)
  #   Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  # end
  
  # def save_posts(tags)
  #   current_tags = self.tags.pluck(:name) unless self.tags.nil?
  #   old_tags = current_tags - tags
  #   new_tags = tags - current_tags
  
  #   # Destroy
  #   old_tags.each do |old_name|
  #     self.tags.delete Tag.find_by(name:old_name)
  #   end
  
  #   # Create
  #   new_tags.each do |new_name|
  #     post_tag = Tag.find_or_create_by(name:new_name)
  #     self.tags << post_tag
  #   end
  # end
  
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
