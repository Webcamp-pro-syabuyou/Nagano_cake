class AddressesController < ApplicationController
  def index
  end

  def new
  end

  def create
    @address = Address.new(address_params)
     if @address.save
     redirect_to thanks_order
     end
  end

  def show
  end

  def edit
  end

 private
  def address_params
    params.require(:address).permit(:postalcode, :address, :delivery_name)
    @address = Address.new(params.require(:address).permit(:postalcode, :address, :delivery_name))
  end

end
