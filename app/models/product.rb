class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id", "id_value", "name", "record_id", "record_type"]
  end
end
