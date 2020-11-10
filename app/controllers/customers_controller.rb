class CustomersController < ApplicationController
  # ログインユーザ以外はcustomerのパスに飛ばずにログイン画面へ
  before_action :authenticate_customer!
  before_action :ensure_correct_customer ,only: [:update, :resign_update]
  
  def show
  end
  
  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customers_path(current_customer), notice: "入力内容を保存しました"
    else
      render "edit"
    end
  end
  
  def resign
  end
  
  # 退会ボタンを押した時、退会フラグを有効(false)から退会(true)へ切り替えるアクション
  def resign_update
    current_customer.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    # flash[:notice] =""
    redirect_to root_path
  end
  
  
  private
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postalcode, :address, :email,:tel)
  end
  
  # 他のユーザがurl入力で遷移してくるのを防ぐ
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    if@customer != current_customer
      redirect_to customers_path
    end
  end
end
