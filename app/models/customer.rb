class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
        validates :last_name, presence: true, length: {minimum:2, maximum:40} 
        validates :first_name, presence: true, length: {minimum:2, maximum:20} 
        validates :last_name_kana, presence: true, length: {minimum:2, maximum:40} 
        validates :first_name_kana, presence: true, length: {minimum:2, maximum:20} 
        validates :postal_code, presence: true, length: {minimum:7, maximum:7} 
        validates :address, presence: true, length: {minimum:2, maximum:50} 
        validates :telephone_number, presence: true, length: {minimum:11, maximum:11} 
        validates :municipality_name, presence: true, length: {minimum:2, maximum:15} 
        
        VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{6,12}\z/
          validates :password, presence: true,
            format: { with: VALID_PASSWORD_REGEX,
             message: "は半角6~12文字英小文字・数字それぞれ１文字以上含む必要があります"}

        has_many :homes, dependent: :destroy
        has_many :donations, dependent: :destroy
        has_many :likes, dependent: :destroy
        has_many :comments, dependent: :destroy  # Customer.comments で、ユーザーのコメント取得
        has_many :reads, dependent: :destroy
end
