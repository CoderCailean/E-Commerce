class CartController < ApplicationController
  def index
    @totalprice = 0

    session[:shopping_cart].each do |item|
      product = Product.find(item["product"])

      @totalprice += product.price * item["quantity"]
    end
    @cartsummary = session[:shopping_cart]
  end

  def create
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    session[:shopping_cart] << {"product" => product_id, "quantity" => quantity}
    # ADD CHECK TO CART, IF ITEM EXISTS UPDATE QUANTITY INSTEAD
    session[:shopping_cart].each do |item|
      # logger.debug(item["product"] == product_id)
    end

  end

  def destroy
    product_id = params[:id].to_i

    session[:shopping_cart].each do |product|

      if(product["product"] == product_id)
        session[:shopping_cart].delete(product)
      end

    end
    redirect_to cart_path method: :index
  end
end

