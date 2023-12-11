# spec/requests/api/meal_spec.rb
require 'swagger_helper'
require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    context 'when user is an admin' do
      it 'returns a list of all meals' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', admin: true)
        sign_in admin_user

        meal1 = Meal.create(name: 'Meal 1', description: 'Delicious meal', price: 10.99, user: admin_user, available: true, photo:"image.jpg")
        meal2 = Meal.create(name: 'Meal 2', description: 'Another tasty meal', price: 12.99, user: admin_user, available: true, photo:"image.jpg")
        meal3 = Meal.create(name: 'Meal 3', description: 'Yummy dish', price: 8.99, user: admin_user, available: true, photo:"image.jpg")

        get :index
        meals_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(meals_response.count).to eq(3)
      end
    end

    context 'when user is not an admin' do
      it 'returns a list of available meals' do
        admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', admin: true)
        normal_user = User.create(email: 'user@example.com', password: 'password', name: 'Normal User', admin: false)
        sign_in normal_user

        # Create available meals for normal user
        meal1 = Meal.create(name: 'Meal 1', description: 'Delicious meal', price: 10.99, user: admin_user, available: true, photo:"image.png")
        meal2 = Meal.create(name: 'Meal 2', description: 'Another tasty meal', price: 12.99, user: admin_user, available: true, photo:"image.png")

        get :index
        meals_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(meals_response.count).to eq(2) # Only available meals for normal user
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new meal' do
      admin_user = User.create(email: 'admin@example.com', password: 'password', name: 'Admin User', admin: true)
      sign_in admin_user

      meal_params = {
        name: 'New Meal',
        description: 'Delicious meal description',
        price: 9.99,
        available: true,
        photo: 'meal.jpg'
      }

      post :create, params: { meal: meal_params }
      expect(response).to have_http_status(:created)
      expect(Meal.count).to eq(1)
    end

    it 'returns status code 401 if user is not authenticated' do
      meal_params = {
        name: 'New Meal',
        description: 'Delicious meal description',
        price: 9.99,
        available: true,
        photo: 'meal.jpg'
      }

      post :create, params: { meal: meal_params }
      expect(response).to have_http_status(:unauthorized)
      expect(Meal.count).to eq(0)
    end
  end

end
