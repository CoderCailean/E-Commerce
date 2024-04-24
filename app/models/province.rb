class Province < ApplicationRecord
  has_many :profiles
  validates :name, :gst, :pst, :hst, presence: true
  validates :gst, :pst, :hst, numericality: {only_integer: true}
end
