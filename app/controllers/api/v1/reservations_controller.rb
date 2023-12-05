class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.all
    render json: @reservations, status: :ok
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.destroy
      head :no_content
    else
      flash.now[:error] = 'Error: Reservation could not be deleted'
    end
  end

  def create
    @reservations = current_user.reservations.new(reservations_params)
  end

end