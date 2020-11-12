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
  end

  def update
    order = Order.find(params[:order][:id])
    order_status = params[:order][:order_status]
    if order.update(order_status: order_status)
      if order.order_status == "入金確認"
        order.order_products.update(product_status: 1)
      elsif order.order_status == "入金待ち"
        order.order_products.update(product_status: 0)
      end
      flash[:notice] = "注文情報を更新しました"
      redirect_to request.referer
    end
  end
end