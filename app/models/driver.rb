class Driver < ApplicationRecord
  has_many :trips
  validates :vin, presence: true
  validates :name, presence: true

  scope :active, -> { where(active: true) }
  scope :available, -> { active }

  def average_rating
    my_trips = self.trips

    if my_trips == nil || my_trips.length == 0
      return 0
    end

    total = 0
    count = 0
    my_trips.each do |trip|
      if !trip.rating.nil?
        total += trip.rating
        count += 1
      end
    end

    average_rating = total.to_f / count

    return average_rating
  end

  def make_and_model
    "#{car_make} #{car_model}"
  end

  def total_earnings
    sum = self.trips.sum do |trip|
      if !trip.price.nil?
        trip.price
      else
        0
      end
    end
    return sum
  end
end
