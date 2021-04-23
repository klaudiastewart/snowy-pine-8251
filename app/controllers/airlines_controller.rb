class AirlinesController < ApplicationController
  def show
    @airline = Airline.find(params[:id])
    @passengers = @airline.airline_passengers
  end
end
