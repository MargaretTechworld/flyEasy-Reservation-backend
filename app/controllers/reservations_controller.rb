class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = @user.reservations.all
  end

  def destroy
    @reservation = @user.reservations.find(params[:id])
    if @reservation.destroy
      redirect_to reservations_path, notice: 'Reservation was successfully deleted.'
    else
      flash.now[:error] = 'Error: Reservation could not be deleted'
    end
  end


end