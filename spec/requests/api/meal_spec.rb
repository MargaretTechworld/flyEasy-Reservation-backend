require '../../swagger_helper'

RSpec.describe Api::V1::MealsController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of available meals' do
      # Crée quelques repas disponibles
      create_list(:meal, 3, available: true)
      # Crée d'autres repas non disponibles
      create_list(:meal, 2, available: false)

      get :index
      meals = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(meals.count).to eq(3) # Vérifie que seuls les repas disponibles sont renvoyés
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    it 'creates a new meal' do
      sign_in user
      meal_params = attributes_for(:meal)

      post :create, params: { meal: meal_params }
      expect(response).to have_http_status(:created)
      expect(Meal.count).to eq(1) # Vérifie que le repas a été créé dans la base de données
    end

    it 'returns status code 401 if user is not authenticated' do
      meal_params = attributes_for(:meal)

      post :create, params: { meal: meal_params }
      expect(response).to have_http_status(:unauthorized)
      expect(Meal.count).to eq(0)
    end
  end
end
