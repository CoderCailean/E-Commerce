class Products < ApplicationRecord
  belongs_to :category, optional: true
  has_many :order_products
  has_one_attached :image

  # def self.ransackable_attributes(auth_object = nil)
  #   ["blob_id", "created_at", "id", "id_value", "name", "record_id", "record_type"]
  # end
end
