class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(5)   # ぺージネーション機能で5つずつ会員を表示するため
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
       @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to admin_customer_path, notice: "会員情報を更新しました"
    else
      flash.now[:alert] = "会員情報の更新に失敗しました"
      render :edit
    end
  end

  def destroy
       @customer = Customer.find(params[:id])
    if @customer.destroy
       redirect_to admin_customers_path, notice: "会員を削除しました"
    else
      flash.now[:alert] = "会員削除に失敗しました"
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_id, :last_name, :first_name, :last_name_kana, :first_name_kana,
                                    :email, :postal_code, :address, :telephone_number,:municipality_name, :is_active)
  end
end
