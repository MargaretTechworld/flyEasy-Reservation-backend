class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.all
    render json: @reservations, status: :ok
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.destroy
      redirect_to reservations_path, notice: 'Reservation was successfully deleted.'
    else
      flash.now[:error] = 'Error: Reservation could not be deleted'
    end
  end

  def create
    current_user
  end

end