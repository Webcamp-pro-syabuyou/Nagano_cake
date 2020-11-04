class Admins::CustomersController < ApplicationController


    def index
        @customers = Customer.all
    end

    def edit
        @customer = Customer.find(params[:id])
        # showページからid受け取っているか要確認
    end

    def update
        customer = Customer.find(params[:id])
        customer.update(customer_params)
        redirect_to admins_customers_path
    end

    def show
        @customer = Customer.find(params[:id])
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    private

    def customer_params
        params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postalcode, :address, :tel, :email, :is_deleted)
    end


end
