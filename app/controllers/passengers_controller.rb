class PassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    remove_pass = flight.passengers.delete(Passenger.find(params[:id]))
    redirect_to "/flights"
  end
end
