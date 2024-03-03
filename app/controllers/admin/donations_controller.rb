class Admin::DonationsController < ApplicationController

  def index
    @donations = Donation.all
    @total = 0
    @donation_payment_total = Donation.sum(:payment_amount)
  end

end
