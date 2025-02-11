require 'rails_helper'

RSpec.describe "Flights Index Page" do
  before(:each) do
    @frontier = Airline.create!(name: "Frontier Airlines")
    @southwest = Airline.create!(name: "Frontier Airlines")
    @flight1 = @frontier.flights.create!(number: "123", date: "12/12/12", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @southwest.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
    @passenger1 = Passenger.create!(name: "Patrick", age: 21)
    @passenger2 = Passenger.create!(name: "Jenna", age: 35)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight2)
    visit "/flights"
  end

  it 'shows list of all flight numbers, airlines of that flight, and their passengers' do
    expect(page).to have_content("All Flights:")

    within("#flight-#{@flight1.id}") do
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight1.airline.name)
      expect(page).to have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger2.name)
    end

    within("#flight-#{@flight2.id}") do
      expect(page).to have_content(@flight2.number)
      expect(page).to have_content(@flight2.airline.name)
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)
    end
  end

  it 'shows a link to remove a passenger from the flights' do
    within("#flight-#{@flight1.id}") do
      expect(page).to have_button("Remove #{@passenger1.name}")
      expect(page).to_not have_button("Remove #{@passenger2.name}")
    end

    within("#flight-#{@flight2.id}") do
      expect(page).to have_button("Remove #{@passenger1.name}")
      expect(page).to have_button("Remove #{@passenger2.name}")
    end
  end

  it 'can click the button to remove a passenger just for that flight' do
    expect(@flight2.passengers.count).to eq(2)

    within("#flight-#{@flight2.id}") do
      click_button "Remove #{@passenger1.name}"
    end

    expect(current_path).to eq("/flights")

    within("#flight-#{@flight1.id}") do
      expect(page).to have_button("Remove #{@passenger1.name}")
      expect(page).to_not have_button("Remove #{@passenger2.name}")
    end

    within("#flight-#{@flight2.id}") do
      within("#passenger-#{@passenger2.id}") do
        expect(page).to have_content("#{@passenger2.name}")
      end

      expect(page).to_not have_content(@passenger1.name)
      expect(@flight2.passengers.count).to eq(1)
    end
  end
end
