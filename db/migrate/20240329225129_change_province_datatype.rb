class ChangeProvinceDatatype < ActiveRecord::Migration[7.1]
  def change
    change_column :provinces, :tax_rate, :integer
  end
end
