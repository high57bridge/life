class Public::DonationsController < ApplicationController

  def new
    @donation = Donation.new
  end

  def create
       @total = 0
       @donation = Donation.new(donation_params)
    if params[:donation]
       redirect_to public_donations_path
    else
      render :complete
    end
  end

  def update
       @donation = Donation(params[:id])
    if @donation.update(donation_params)
       redirect_to public_donations_path
    else
      render :index
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:customer_id, :payment_amount, :payment_method, :area)
  end

end
