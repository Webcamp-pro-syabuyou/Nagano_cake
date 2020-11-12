class Admins::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_product = OrderProduct.find(params[:order_product][:id])
    product_status = params[:order_product][:product_status]
    id = order_product.order_id
    order = Order.find(id)
    if order_product.update(product_status: product_status)
      if order.order_products.where(product_status: "制作完了").count == order.order_products.count
        order.update(order_status: 3)
      elsif order.order_products.where(product_status: "制作完了").any?
        order.update(order_status: 2)
      elsif order.order_products.where(product_status: "制作完了").count != order.order_products.count
        order.update(order_status: 2)
      end
      flash[:notice] = "注文商品情報を更新しました"
      redirect_to request.referer
    end
  end

end