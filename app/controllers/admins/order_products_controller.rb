class Admins::OrderProductsController < ApplicationController

  def update
    order_product = OrderProduct.find(params[:order_product][:id])
    product_status = params[:order_product][:product_status]
    # .to_iを入れなければ正常にupdateされてその後のセレクトボックスも現在のカラムが反映される
    # f.select :product_status, OrderProduct.product_statuses.keys.to_a, {}のフォーム形式の場合文字列の"製作完了"etc.でparamsで受け取っている為、.to_iが不要
    # string型のままupdateしてるけど、モデルファイルの記述のおかげで自動的に対応するintegerで保存される？
    # モデルファイルの記述の整数のinteger型か、valueである文字列のstring型ならどっちでも保存できそう？
    if order_product.update(product_status: product_status)
      flash[:notice] = "You have successfully updated product status"
      redirect_to request.referer
    end
  end

end
