class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orderproducts = OrderProduct.where(order_id: params[:id])
    @products = []
    @order_total = 0
    @province = Provinces.find(user.provinces_id)
    product_ids = []

    @orderproducts.each do |product|

      @products.push(
        {
          "product" => Product.find(product.product_id),
          "quantity" => product.quantity,
          "sale_price" => product.sale_price
        }
      )

      @order_total += product.sale_price * product.quantity
    end

  end
end
