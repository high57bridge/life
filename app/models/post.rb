class Post < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  has_many :comments, dependent: :destroy
end
