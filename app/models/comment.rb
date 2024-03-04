class Comment < ApplicationRecord
  
  belongs_to :customer  # Comment.post で、コメントされた投稿取得
  belongs_to :post      # Comment.customer で、コメント投稿者取得
  belongs_to :parent,  class_name: "Comment", optional: true   # 返信対象となるコメントのID
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy   # 返信されたコメント
  # validates :comment, presence: true, length: { in: 1..1000 }  # 空をバリデーション、文字数制限
  
end
