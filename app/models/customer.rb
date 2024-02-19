class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
        # has_many :homes, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         
end
