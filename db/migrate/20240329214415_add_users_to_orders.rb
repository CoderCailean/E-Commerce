class AddUsersToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :users, null: false, foreign_key: true
  end
end
