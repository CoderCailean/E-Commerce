class ApplicationController < ActionController::Base

  before_action :initialize_session
  helper_method :cart, :logout, :user

  private
  def initialize_session
    session[:shopping_cart] ||= [] # Represents an empty array of product id's
  end

  def logout
    session[:user_id] = nil
    puts "Session - #{session[:user_id]}"
    redirect_to root_path, notice: 'Logged Out'
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

  def user
    user = Users.find(session[:user_id])
  end

end
