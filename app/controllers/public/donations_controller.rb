class Public::DonationsController < ApplicationController
  
  def index
    # @donations = current_customer.donations
  end
  
  def new
    @donation = Donation.new
  end
  
  def confirm
    @donation = Donation.new(donation_params)
  end

  def create
      @donation = Donation.new(donation_params)
      @donation.save
    current_customer.donations.each do |donation|
      @donation_details = OrderDetail.new
      @donation_details.payment_amount = donation.payment_amount
      @donation_details.payment_method = donation.payment_method
      @donation_details.donation_id = @donation.id
      @donation_details.save
    end
      redirect_to complete_public_donations_path
  end

  def update
       @donation = Donation(params[:id])
    if @donation.update(donation_params)
       redirect_to public_donations_path
    else
      render :index
    end
  end
  
  def show
    @donation = Donation.find(params[:id])
  end
  
  private

  def donation_params
    params.require(:donation).permit(:customer_id, :payment_amount, :payment_method, :area)
  end

end
