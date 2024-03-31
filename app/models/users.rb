class Users < ApplicationRecord
  has_many :orders
  belongs_to :provinces, optional: true
end
