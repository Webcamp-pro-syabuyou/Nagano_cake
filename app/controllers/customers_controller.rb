class CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    if @cusotmer.update(customer_params)
      redirect_to customer_path(@customer), notice: "サクセスメッセージ"
    else
      render "edit"
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postalcode, :address, :tel)
  end
end
