class Comment < ApplicationRecord
  
  belongs_to :customer  # Comment.post で、コメントされた投稿取得
  belongs_to :post      # Comment.customer で、コメント投稿者取得
  
end
