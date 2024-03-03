class Public::HomesController < ApplicationController

  def about
    @home = Home.new
  end

  def create
      @home = Home.new(home_params)
    if @home.save
      flash[:notice]= "送信しました"
      redirect_to complete_path
    else
      @homes = Home.all
      render :new
    end
  end

  private

  def home_params
    params.require(:home).permit(:name, :email, :opinion, :is_active)
  end

end