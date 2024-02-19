class Public::HomesController < ApplicationController

  def about
    @home = Home.new
  end
  
  def create
      @home = Home.new(home_params)
    if @home.save
      flash[:notice]= "投稿に成功しました"
      redirect_to complete_path
    else
      @homes = home.all
      render :new
    end
  end
  
  private
  
  def home_params
    params.require(:home).permit(:name, :email, :opinion)
  end

end
