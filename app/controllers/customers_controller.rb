class CustomersController < ApplicationController
  def edit
    @custmer = Customer.find(params[:id])
  end

  def update
    if @custmer.update(custmer_params)
      redirect_to custmer_path(@custmer), notice: "サクセスメッセージ"
    else
      render "edit"
    end
  end
  
  private
  def custmer_params
    params.require(:custmer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postalcode, :address, :tel)
  end
end
