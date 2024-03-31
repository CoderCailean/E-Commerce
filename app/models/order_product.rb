class OrderProduct < ApplicationRecord
  belongs_to :products, optional: true
  belongs_to :order, optional: true
end
