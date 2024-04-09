class SignupController < ApplicationController

  def index

    @new_email = params[:email]
    @password = params[:password]
    @verify_password = params[:password2]

    if(@new_email == "")
      flash[:error] = "No email provided"
      return
    end

    existing_user = Users.find_by(email: @new_email)

    if(existing_user.nil?)
      if(@password != @verify_password)
        flash[:error] = "Passwords must match."
        return
      end
    else
      flash[:error] = "Email already in use."
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
      redirect_to root_path, notice: "Logged In"
    else

    end
  end
end
