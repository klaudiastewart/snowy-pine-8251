class Airline < ApplicationRecord
  has_many :flights

  def airline_passengers
    flights
          .joins(:passengers)
          .select('passengers.*')
          .where('age > ?', 18)
          .distinct(:name)
  end
end
