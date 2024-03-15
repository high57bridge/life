class Admin::DonationsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @donations = Donation.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ寄付履歴表示するため
    @total = 0
    @donation_payment_total = Donation.sum(:payment_amount)
  end

end