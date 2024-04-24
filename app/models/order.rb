class Order < ApplicationRecord
  has_many :order_products
  belongs_to :user, optional: true
  validates :order_date, :fulfillment_status, presence: true
  validates :fulfillment_status, numericality: {only_integer: true}
end
