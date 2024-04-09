class SignupController < ApplicationController

  def index

  end

  def create
      @new_email = params[:email]
      @password = params[:password]
      @verify_password = params[:password2]

      if(@new_email == "")
        flash[:error] = "No email provided"
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
        return
      end

      existing_user = Users.find_by(email: @new_email)

      if(existing_user.nil?)

      else
        flash[:error] = "Email already in use."
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
        return
      end

      if(@password || @verify_password == "")
        flash[:error] = "Please enter a password."
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
        return
      end

      if(@password != @verify_password)
        flash[:error] = "Passwords must match."
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
        return
      end

      new_user = Users.create(
        email: @new_email,
        password: @password,
        full_name: "New User",
        address: "null",
        provinces_id: 1
      )

      if(new_user.valid?)
        session[:user_id] = new_user.id

        redirect_to root_path, notice: "Logged In"
      else
        respond_to do |format|
          format.html{redirect_back(fallback_location: root_path)}
          format.js
        end
        return
      end
    end
  end