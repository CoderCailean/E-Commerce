class AccountController < ApplicationController
  def index
    if(current_user)
      @user = User.find(current_user.id)
      @profile = Profile.find_by(user_id: current_user.id)
      @orders = Order.where(user_id: current_user.id)
    end
  end
end
