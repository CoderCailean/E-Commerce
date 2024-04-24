class Product < ApplicationRecord
  has_many :order_products
  belongs_to :categories, optional: true

  has_one_attached :image

  validates :name, :price, :description, presence: true
  validates :price, numericality: true
end
