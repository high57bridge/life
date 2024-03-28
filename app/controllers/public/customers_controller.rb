class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
    @likes = Like.where(customer_id: current_customer.id)
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to mypage_public_customers_path
    else
      flash.now[:alert] = "会員情報の更新に失敗しました"
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました。またのご利用お待ちしております。"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
                                     :postal_code, :address, :email, :municipality_name, :telephone_number)
  end
end
