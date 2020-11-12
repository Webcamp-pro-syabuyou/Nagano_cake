class AddressesController < ApplicationController
  # ログイン済ユーザに対してのみアクセスを許可（それ以外sign_inへ）
  before_action :authenticate_customer!
  before_action :ensure_correct_customer ,only:[:edit, :update, :destroy ]

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to customers_addresses_path, notice: "配送先を登録しました"
    else
      @addresses = Address.where(customer_id: current_customer)
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to customers_addresses_path, notice: "配送先情報を変更しました"
    else
      @addresses = Address.where(customer_id: current_customer)
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    redirect_to customers_addresses_path,notice: "配送先を削除しました"
  end

  private
  def address_params
    params.require(:address).permit(:postalcode, :address, :delivery_name)
  end

  def ensure_correct_customer
    @address = Address.find(params[:id])
    if @address.customer != current_customer
      redirect_to customers_path
    end
  end

end