# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@frontier = Airline.create!(name: "Frontier Airlines")
@southwest = Airline.create!(name: "Frontier Airlines")
@flight1 = @frontier.flights.create!(number: "123", date: "12/12/12", departure_city: "Denver", arrival_city: "Reno")
@flight2 = @southwest.flights.create!(number: "321", date: "10/10/10", departure_city: "Reno", arrival_city: "Denver")
@passenger1 = Passenger.create!(name: "Patrick", age: 21)
@passenger2 = Passenger.create!(name: "Jenna", age: 35)
PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
PassengerFlight.create!(passenger: @passenger2, flight: @flight2)
