class OrderProduct < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  validates :quantity, :price, presence: true
  validates :quantity, :price, is_numeric: true
end
