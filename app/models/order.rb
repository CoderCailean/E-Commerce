class Order < ApplicationRecord
  belongs_to :users, optional: true
  has_many :order_products
end
