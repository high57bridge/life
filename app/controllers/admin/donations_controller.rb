class Admin::DonationsController < ApplicationController
  def index
    @donations = Donation.all
    @total = 0
  end
  
end
