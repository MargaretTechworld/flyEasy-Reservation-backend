class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = @user.reservations.all
  end

end