class Airline < ApplicationRecord
  has_many :flights

  def airline_passengers
    flights
          .joins(:passengers)
          .select('passengers.*')
          .where('age > ?', 18)
          .distinct(:name)
  end

  def frequent_fliers
    flights
          .joins(:passengers, :passenger_flights)
          .where('age > ?', 18)
          .select("passengers.*, passenger_flights.*")
          .group('passengers.id', 'passenger_flights.id')
          .order(x)
          #not sure how to order this method out...
  end
end
