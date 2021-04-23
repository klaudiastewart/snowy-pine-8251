require 'rails_helper'

RSpec.describe "Flights Index Page" do
  before(:each) do
    @frontier = Airline.create!(name: "Frontier Airlines")
    @southwest = Airline.create!(name: "Frontier Airlines")
    @flight1 = @frontier.flights.create!(number: "123", date: "12/12/12", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @frontier.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
    @flight3 = @southwest.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
    @passenger1 = Passenger.create!(name: "Patrick", age: 21)
    @passenger2 = Passenger.create!(name: "Jenna", age: 35)
    @passenger3 = Passenger.create!(name: "Klaudia", age: 5)
    @passenger4 = Passenger.create!(name: "Patrick", age: 40)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight3)
    PassengerFlight.create!(passenger: @passenger3, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger4, flight: @flight1)
    visit "/airlines/#{@frontier.id}"
  end

  it 'shows passengers on this airline and not any on this airline that are unique and an adult' do
    expect(page).to have_content(@passenger1.name)
    expect(page).to have_content(@passenger4.name)
    expect(page).to_not have_content(@passenger3.name)
    expect(page).to_not have_content(@passenger2.name)
  end
end
