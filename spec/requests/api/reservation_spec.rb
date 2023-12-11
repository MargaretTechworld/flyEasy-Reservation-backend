# spec/requests/api/reservation_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    it 'returns a list of user reservations with meal details' do
      normal_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', admin: false)
      meal1 = Meal.create(name: 'Meal 1', description: 'Delicious meal', price: 10.99, user: admin_user, available: true, photo:"image.jpg")
      sign_in normal_user
      reservation1 = Reservation.create(reserve_time: '12:00', quantity: 2, spicy_level: 'medium',reserve_date: '2023-01-01', user: normal_user, meal: meal1)
      get :index
      reservations_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(reservations_response.count).to eq(1)
    end
  end

  describe 'POST #create' do
    context 'when creating a new reservation' do
      it 'creates a new reservation' do
        user = create(:user)
        sign_in user

        meal = create(:meal)

        reservation_params = {
          reserve_time: '12:00',
          quantity: 2,
          spicy_level: 'medium',
          reserve_date: '2023-01-01'
        }

        post :create, params: { meal_id: meal.id, reservation: reservation_params }
        reservation_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(reservation_response['id']).not_to be_nil
      end
    end

    context 'when updating an existing reservation' do
      it 'updates the existing reservation quantity' do
        user = create(:user)
        sign_in user

        meal = create(:meal)
        reservation = create(:reservation, user: user, meal: meal, quantity: 1)

        reservation_params = {
          reserve_time: reservation.reserve_time.strftime('%H:%M'),
          quantity: 2,
          spicy_level: reservation.spicy_level,
          reserve_date: reservation.reserve_date
        }

        post :create, params: { meal_id: meal.id, reservation: reservation_params }
        updated_reservation = Reservation.find(reservation.id)

        expect(response).to have_http_status(:ok)
        expect(updated_reservation.quantity).to eq(3) # Existing quantity + new quantity
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the reservation' do
      user = create(:user)
      sign_in user

      reservation = create(:reservation, user: user)

      delete :destroy, params: { id: reservation.id }

      expect(response).to have_http_status(:no_content)
      expect { Reservation.find(reservation.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
