class Driver < ApplicationRecord
  has_many :trips

  scope :active, -> { where(active: true) }
  scope :available, -> { active }

  def average_rating
    my_trips = self.trips

    if my_trips == nil || my_trips.length == 0
      return 0
    end

    total = 0
    my_trips.each do |trip|
      total += trip.rating
    end

    average_rating = total.to_f / my_trips.length

    return 1
  end

  def make_and_model
    "#{car_make} #{car_model}"
  end
end
