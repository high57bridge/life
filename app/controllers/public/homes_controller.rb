class Public::HomesController < ApplicationController
  
  def index
    @homes = Home.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ投稿を表示するため
  end

  def about
    @home = Home.new
  end

  def create
      @home = Home.new(home_params)
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