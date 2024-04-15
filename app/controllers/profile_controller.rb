class ProfileController < ApplicationController
  def index
    if(current_user)
      @user = User.find(current_user.id)
      @profile = Profile.find_by(user_id: current_user.id)

      if(@profile.nil?)
      else
        @user_province = Provinces.find(@profile.province_id)
      end

      @orders = Order.where(user_id: current_user.id)


      provinces = Provinces.all
      @province_ids = []
      provinces.each do |province|
        @province_ids.push(province.name)
      end
    end
  end

  def create

    name = params[:name] || ""
    address = params[:address] || ""
    province_name = params[:province]
    postal_code = params[:postal_code] || ""
    method = params[:method] || "create"

    province = Provinces.find_by(name: province_name)
    puts province.inspect

    if(method == "update")
      existing_profile = Profile.find_by(user_id: current_user.id)

      existing_profile.update(
        full_name: name,
        address: address,
        postal_code: postal_code,
        province_id: province.id,
      )
    else
      new_profile = Profile.create!(
        full_name: name,
        address: address,
        postal_code: postal_code,
        province_id: province.id,
        user_id: current_user.id
      )
    end


    respond_to do |format|
      format.html{redirect_back(fallback_location: root_path)}
      format.js
    end
  end
end
