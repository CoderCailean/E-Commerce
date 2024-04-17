class Province < ApplicationRecord
  has_many :profiles
  # validates :name, :gst, :pst, :hst, presence: true
  # validates :gst, :pst, :hst, is_numeric: true
end
