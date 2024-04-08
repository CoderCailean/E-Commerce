class AccountController < ApplicationController
  def index
    @user = Users.find(session[:user_id])
    @orders = Order.where(user_id: session[:user_id])
  end
end
