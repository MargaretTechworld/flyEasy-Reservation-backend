class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.all
    render json: @reservations, status: :ok
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
    render json: @reservation, status: :ok
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.destroy
      head :no_content
    else
      render json: 'Reservation could not be deleted'
    end
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @reservation = @meal.reservations.new(reservation_params.merge(user: current_user))
    if @reservation.save
      render json: @reservation, status: 'Created'
    else
      render json: { data: @reservation.errors.full_messages, message: "Couldn't create the reservation" },
             status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:reserve_time, :quantity, :spicy_level, :reserve_date)
  end
end
