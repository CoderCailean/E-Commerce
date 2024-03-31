class LoginController < ApplicationController
  def index

  end

  def create
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email)

    if(user)
      if(user.password == password)
        session[:user_id] = user.id

        redirect_to root_path, notice: "Logged In"
      else
        flash[:error] = true
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
      end
    else
      flash[:error] = true
      respond_to do |format|
        format.html{redirect_back(fallback_location: root_path)}
        format.js
      end
    end
  end
end
