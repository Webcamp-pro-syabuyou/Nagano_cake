class Admins::CustomersController < ApplicationController

    def index
        @customers = Customer.all
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
            flash[:notice] = "You have successfully changed customer's information"
            redirect_to admins_customers_path
        else
            render 'admins/customers/edit'
        end
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
