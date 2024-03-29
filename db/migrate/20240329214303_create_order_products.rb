class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
