class AddProvincesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :provinces, null: false, foreign_key: true
  end
end
