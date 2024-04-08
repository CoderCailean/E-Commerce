class AddedGstPstHstColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :provinces, :tax_rate
    add_column :provinces, :gst, :integer
    add_column :provinces, :pst, :integer
    add_column :provinces, :hst, :integer
  end
end
