class Driver < ApplicationRecord
  has_many :trips

  scope :active, -> { where(active: true) }

  def self.available
    # I tried for hours but could not find a way to do this
    # without resorting to raw SQL with the condition from `ongoing`
    # hard-coded. Arel could also be used, but has the same problem
    # with needing to be hard-coded AFAICT.
    #
    # This should be fine for the students to write, but it does
    # result in between n and 2n DB queries, where n is active drivers
    active.select do |d|
      d.trips.count == 0 || d.trips.ongoing.count == 0
    end
  end

  def average_rating
    return 1
  end

  def make_and_model
    "#{car_make} #{car_model}"
  end

  def current_trip
    trips.ongoing.first
  end

  def pickup!
    current_trip.update(status: :travel)
  end
end
