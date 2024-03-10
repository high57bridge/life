class Comment < ApplicationRecord
  
  belongs_to :customer  # Comment.post で、コメントされた投稿取得
  belongs_to :post      # Comment.customer で、コメント投稿者取得
  validates :comment, presence: true, length: { in: 1..1000 }  # 空をバリデーション、文字数制限

end
