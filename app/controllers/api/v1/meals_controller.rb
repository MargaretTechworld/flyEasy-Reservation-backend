class Api::V1::MealsController < ApplicationController
  before_action :meal_find_id, only: %i[show destroy]


  def index
    @meals = Meals.all
    render json: @meals, status: :ok
  end

  def show
  end

  def new
  end

  private

  def meal_find_id
    @meal = Meals.find(params[:id])
  end

  def meal_params
    params.require(:meals).permit(:name, :description, :price)
  end
end