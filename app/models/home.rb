class Home < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :opinion, presence: true
  
  belongs_to :customer
end
