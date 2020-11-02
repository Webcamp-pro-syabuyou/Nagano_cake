class AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to address_path, notice: "サクセスメッセージ"
    else
      @addresses = Address.all
      render 'index'
    end
  end

  def edit
    @address = address.find(params[:id]) 
  end
  
  def update
    if @address.update(address_params)
      redirect_to address_path, notice: "サクセスメッセージ"
    else
      @addresses = Address.all
      render 'index'
    end
  end
  
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to address_path,notice: "サクセスメッセージ"
  end
  
  private
  def address_params
    params.require(:address).permit(:postcode, :adress, :delivery_name)
  end

end