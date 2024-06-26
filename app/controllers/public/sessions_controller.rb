# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_session, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = "abcd1234"
      customer.last_name = "guest"
      customer.first_name = "guest"
      customer.last_name_kana = "guest"
      customer.first_name_kana = "guest"
      customer.postal_code = "3331234"
      customer.address = "guest"
      customer.telephone_number = "07012341234"
      customer.municipality_name = "guest"
      # customer.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name), status: :see_other }
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_active
      flash[:notice] = "ログインしました"
      root_path
    else
      flash[:notice] = nil
      flash[:alert] = "既に退会済みのためログインできません"
      sign_out(resource)
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
