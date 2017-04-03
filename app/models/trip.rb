class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  scope :ongoing, -> { where(rating: nil) }
end
