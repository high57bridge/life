class Home < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :opinion, presence: true
end
