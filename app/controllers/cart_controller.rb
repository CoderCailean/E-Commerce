class CartController < ApplicationController
  def index
    @totalprice = 0
    @government_rate = 5
    if(current_user)
      profile = Profile.find_by(user_id: current_user.id)
      province = Provinces.find(profile.province_id)
      @provincial_rate = province.pst
    else
      @provincial_rate = 0
    end

    session[:shopping_cart].each do |item|
      product = Product.find(item["product"])

      @totalprice += product.price * item["quantity"]
    end
    @cartsummary = session[:shopping_cart]
  end

  def create
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    method = params[:method]

    cart_contains_product = false

    session[:shopping_cart].each do |item|
      if(item["product"].to_i == product_id)

        cart_contains_product = true

        if(method == "update")
          item["quantity"] = quantity
        else
          item["quantity"] += quantity
        end
      end
    end

    if(!cart_contains_product)
      session[:shopping_cart] << {"product" => product_id, "quantity" => quantity}
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

