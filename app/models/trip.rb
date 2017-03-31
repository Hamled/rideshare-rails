class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  enum status: [
    :pickup, # After passenger requests ride, until pickup has been confirmed by driver
    :travel, # After pickup has been confirmed, until dropoff has been confirmed by driver
    :dropoff, # After dropoff has been confirmed, until rating has been given by passenger (price set here)
    :complete # After rating has been given by passenger
  ]
end
