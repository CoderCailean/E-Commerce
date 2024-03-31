class RemoveForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :user_id
  end
end
