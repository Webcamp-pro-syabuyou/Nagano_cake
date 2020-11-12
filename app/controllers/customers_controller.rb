class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    if current_customer.update(customer_params)
      flash[:notice] = "お客様情報を更新しました"
      redirect_to customers_path(current_customer)
    else
      render "edit"
    end
  end

  def resign
  end

  def resign_update
    current_customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :email, :postalcode, :address, :tel)
  end
end