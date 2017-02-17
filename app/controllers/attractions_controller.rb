require 'pry'
class AttractionsController < ApplicationController
  include ApplicationHelper

  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find_by(id: params[:id])
  end

  def ride
    ride = Ride.create(user_id: current_user.id, attraction_id: params[:attraction_id])
    ride_message = ride.take_ride
    attraction = Attraction.find(params[:attraction_id])
    if ride_message == true
      redirect_to user_path(current_user), alert: "Thanks for riding the #{attraction.name}!"
    else
      redirect_to user_path(current_user), alert: ride_message
    end
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to new_attraction_path, alert: "Invalid input for attraction creation."
    end
  end

  def edit
    @attraction = Attraction.find_by(id: params[:id])
  end

  def update
    @attraction = Attraction.find_by(id: params[:id])
    @attraction.update(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to edit_attraction_path(@attraction), alert: "Invalid inputs for updating."
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end

  def check_admin
    unless current_user.admin
      redirect_to user_path(current_user), alert: "Only ADMIN may complete this action."
    end
  end
end
