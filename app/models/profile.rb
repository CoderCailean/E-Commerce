class Profile < ApplicationRecord
  belongs_to :province, optional: true
end
