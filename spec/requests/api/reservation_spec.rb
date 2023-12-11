# spec/requests/api/reservation_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    context 'when user is authenticated' do
      it 'returns a list of user reservations with meal details' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', admin: true)
        sign_in admin_user

        meal = Meal.create(name: 'Meal 1', description: 'Delicious meal', price: 10.99, user: admin_user, available: true, photo:"image.jpg")
        reservation = Reservation.create(reserve_time: '12:00', quantity: 2, spicy_level: 'medium', reserve_date: '2023-01-01', user: admin_user, meal: meal)

        get :index
        reservations_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(reservations_response.count).to eq(1)
      end
    end
  end

 
end
