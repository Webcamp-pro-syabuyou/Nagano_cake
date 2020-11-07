class AddressesController < ApplicationController
  # ログイン済ユーザに対してのみアクセスを許可（それ以外sign_inへ）
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = Address.all
  end

  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    # アドレス変数にユーザIDを紐づける
    if @address.save
    redirect_to customers_addresses_path, notice: "サクセスメッセージ"
    else
      @addresses = Address.all
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id]) 
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to customers_addresses_path, notice: "サクセスメッセージ"
    else
      @addresses = Address.all
      render 'index'
    end
  end
  
  
  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    redirect_to customers_addresses_path,notice: "サクセスメッセージ"
  end
  
  private
  def address_params
    params.require(:address).permit(:postalcode, :address, :delivery_name)
  end


end
