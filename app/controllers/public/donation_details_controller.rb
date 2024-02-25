class Public::DonationDetailsController < ApplicationController
  def index
    @donations = current_customer.donations
  end

  def show
    @donation = Donation.find(params[:id])
    # @total = 0
  end
end
