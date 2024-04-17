class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.integer :gst
      t.integer :pst
      t.integer :hst

      t.timestamps
    end
  end
end
