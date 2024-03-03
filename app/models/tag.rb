class Tag < ApplicationRecord
 validates :name, presence: true, length: { maximum: 50 }
  has_many :hashtags, dependent: :destroy
  has_many :posts, through: :hashtags
end
