class Admin::DonationsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @donations = Donation.all
    @total = 0
    @donation_payment_total = Donation.sum(:payment_amount)
  end

end