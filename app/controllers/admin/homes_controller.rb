class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @homes = Home.all
  end

  def show
    @home = Home.find(params[:id])
  end

  def update
       @home = Home.find(params[:id])
    if @home.update(home_params)
       redirect_to top_path
    else
      render :show
    end
  end

  private

  def home_params
    params.require(:home).permit(:is_active, :status)
  end
end
