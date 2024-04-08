class AddedColumnToOrderProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :order_products, :sale_price, :decimal
  end
end
