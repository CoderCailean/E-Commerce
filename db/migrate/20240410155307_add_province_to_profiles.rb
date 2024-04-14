class AddProvinceToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_reference :profiles, :province, null: false, foreign_key: true
  end
end
