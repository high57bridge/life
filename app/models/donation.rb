class Donation < ApplicationRecord

  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1, paypay: 2 }

end
