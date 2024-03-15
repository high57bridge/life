class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
        validates :last_name, presence: true
        validates :first_name, presence: true
        validates :last_name_kana, presence: true
        validates :first_name_kana, presence: true
        validates :postal_code, presence: true
        validates :address, presence: true
        validates :telephone_number, presence: true
        validates :municipality_name, presence: true

        # has_many :posts, dependent: :destroy
        has_many :donations, dependent: :destroy
        has_many :likes, dependent: :destroy
        has_many :comments, dependent: :destroy  # Customer.comments で、ユーザーのコメント取得
        has_many :reads, dependent: :destroy
end
