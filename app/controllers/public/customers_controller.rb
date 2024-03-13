class Public::CustomersController < ApplicationController
  
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
      redirect_to information_public_customers_path
    else
      @customer = current_customer
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to unsubscribe_public_customers_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
                                     :postal_code, :address, :email, :municipality_name, :telephone_number)
  end
end
