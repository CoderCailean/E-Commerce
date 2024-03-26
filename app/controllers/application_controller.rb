class ApplicationController < ActionController::Base

  before_action :initialize_session
  helper_method :cart

  private
  def initialize_session
    session[:shopping_cart] ||= [] # Represents an empty array of product id's
  end

  def cart
    user_products = []

    session[:shopping_cart].each do |item|

      product = Product.find(item["product"])
      user_products.push({
          "product" => product,
          "quantity" => item["quantity"]
        }
      )
    end
    user_products
  end

end
