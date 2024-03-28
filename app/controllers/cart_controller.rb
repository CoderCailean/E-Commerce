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

    cart_contains_product = false

    session[:shopping_cart].each do |item|
      if(item["product"].to_i == product_id)
        cart_contains_product = true
        if(quantity != 0)
          item["quantity"] += quantity
        end
      end
    end

    if(!cart_contains_product)
      session[:shopping_cart] << {"product" => product_id, "quantity" => quantity}
    end

    # ADD CHECK TO CART, IF ITEM EXISTS UPDATE QUANTITY INSTEAD

    session[:shopping_cart].each do |item|
      # logger.debug(item["product"] == product_id)
    end

    respond_to do |format|
      format.html{redirect_back(fallback_location: root_path)}
      format.js
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

