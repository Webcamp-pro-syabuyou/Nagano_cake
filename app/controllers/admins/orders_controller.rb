class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def number

    range = Date.today.beginning_of_day..Date.today.end_of_day
    @order = Order.where(created_at: range).count
  end

  def index
    @orders = Order.page(params[:page]).per(10).all.order(created_at: "DESC")
  end

  def show
    @order = Order.find_by(id: params[:id])
    # @order = Order.find(params [:id])ではなぜでないの？
    # id = @order.customer_id
    # customer = Customer.find(id)
    # @order_products = customer.purchased_products
  end

  def update
    # binding.pry
    order = Order.find(params[:order][:id])
    order_status = params[:order][:order_status]
    if order.update(order_status: order_status)
      flash[:notice] = "注文情報を更新しました"
      redirect_to request.referer
    end
    # <%= f.select :order_status, [["入金待ち",0],["入金確認",1,],["製作中",2],["発送準備中",3],["発送済み",4]] %>
    # 上のフォーム形式を使用すると、対応する数字とvalue値がshowビューで設定したものなので、redirectした際にカラムの情報を自動で受け取って表示されない = リストの一番上の選択肢が表示されてしまう
  end
end
