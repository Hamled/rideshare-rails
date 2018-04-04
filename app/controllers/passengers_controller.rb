class PassengersController < ApplicationController

  before_action :find_passenger, only: [:show, :edit, :destroy, :update, :complete_trip]



  def index
    @passengers = Passenger.order(:name).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new(passenger_params)

    if passenger.save
      redirect_to passengers_path
    else
      flash[:alert] = ""
      passenger.errors.messages.keys.each do |key|
        passenger.errors.messages[key].each do |msg|
          flash[:alert] = "#{flash[:alert]} #{flash[:alert] == "" ? "": "<br>"}  #{key}:  #{msg}"
        end
      end

      redirect_back(fallback_location: passengers_path)
    end
  end

  def edit
  end

  def update
    @passenger.name = passenger_params[:name]
    @passenger.phone_number = passenger_params[:phone_number]

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      flash[:alert] = ""
      passenger.errors.messages.keys.each do |key|
        passenger.errors.messages[key].each do |msg|
          flash[:alert] = "#{flash[:alert]} #{flash[:alert] == "" ? "": "<br>"}  #{key}:  #{msg}"
        end
      end

      redirect_back(fallback_location: passengers_path)
    end
  end

  def destroy

    @passenger.trips.each do |trip|
      trip.destroy
    end

    @passenger.destroy
    redirect_to passengers_path
  end

  def complete_trip
    redirect_to @passenger, alert: "A trip rating must be provided" unless params[:rating].present?

    @passenger.complete_trip!(params[:rating])
    redirect_to @passenger
  end

  private
    def find_passenger
      @passenger = Passenger.find(params[:id])
    end
    def passenger_params
        params.require(:passenger).permit(:name, :phone_number)
    end
end
