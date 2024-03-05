class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
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
       redirect_to admin_customer_path
    else
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
