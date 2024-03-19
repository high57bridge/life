class Public::HomesController < ApplicationController
  
  def index
    @homes = current_customer.homes
  end

  def about
    @home = Home.new
  end

  def create
      @home = Home.new(home_params)
      @home.customer_id = current_customer.id
    if @home.save
      redirect_to complete_path
    else
      @homes = Home.all
      render "public/homes/about"
    end
  end

  private

  def home_params
    params.require(:home).permit(:name, :email, :opinion, :is_active)
  end

end