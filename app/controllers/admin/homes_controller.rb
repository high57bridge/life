class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @homes = Home.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ要望表示するため
  end

  def show
    @home = Home.find(params[:id])
  end

  def update
       @home = Home.find(params[:id])
    if @home.update(home_params)
       redirect_to top_path, notice: "ステータスを更新しました"
    else
      flash.now[:alert] = "ステータスの更新に失敗しました"
      render :show
    end
  end

  private

  def home_params
    params.require(:home).permit(:is_active, :status)
  end
end
