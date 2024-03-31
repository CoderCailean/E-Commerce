class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orderproducts = OrderProduct.where(orders_id: params[:id])
    @products = []
    product_ids = []

    @orderproducts.each do |product|

      @products.push(
        {
          "product" => Product.find(product.products_id),
          "quantity" => product.quantity
        }
      )
    end

  end
end
