require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
  end

  describe 'instance methods' do
    before(:each) do
      @frontier = Airline.create!(name: "Frontier Airlines")
      @southwest = Airline.create!(name: "Frontier Airlines")
      @flight1 = @frontier.flights.create!(number: "123", date: "12/12/12", departure_city: "Denver", arrival_city: "Reno")
      @flight2 = @frontier.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
      @flight3 = @southwest.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
      @passenger1 = Passenger.create!(name: "Patrick", age: 21)
      @passenger2 = Passenger.create!(name: "Jenna", age: 35)
      @passenger3 = Passenger.create!(name: "Klaudia", age: 5)
      @passenger4 = Passenger.create!(name: "Dave", age: 45)
      PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
      PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
      PassengerFlight.create!(passenger: @passenger2, flight: @flight3)
      PassengerFlight.create!(passenger: @passenger3, flight: @flight1)
      PassengerFlight.create!(passenger: @passenger4, flight: @flight1)
    end

    describe '#airline_passengers' do
      it 'shows unique passengers that are adults' do
        expect(@frontier.airline_passengers.count).to eq(2)
        expect(@frontier.airline_passengers[0].name).to eq(@passenger1.name)
        expect(@frontier.airline_passengers[0].age).to eq(@passenger1.age)
        expect(@frontier.airline_passengers[1].name).to eq(@passenger4.name)
        expect(@frontier.airline_passengers[1].age).to eq(@passenger4.age)
        expect(@frontier.airline_passengers).to_not include(@passenger2)
        expect(@frontier.airline_passengers).to_not include(@passenger3)
      end
    end
  end
end
