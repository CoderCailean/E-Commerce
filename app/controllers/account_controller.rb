class AccountController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @orders = Order.where(users_id: session[:user_id])
  end
end
