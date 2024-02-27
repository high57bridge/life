class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_many :posts, dependent: :destroy
         has_many :donations, dependent: :destroy
         has_many :comments, dependent: :destroy  # Customer.comments で、ユーザーのコメント取得
         validates :comment, presence: true, length: { maximum: 1000 }   # 空をバリデーション、文字数制限
         has_many :favorites, dependent: :destroy
         has_many :bookmarks, dependent: :destroy

end
