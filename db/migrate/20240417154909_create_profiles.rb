class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :address
      t.string :postal_code

      t.timestamps
    end
  end
end
