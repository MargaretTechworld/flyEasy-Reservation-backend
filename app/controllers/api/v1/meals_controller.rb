class Api::V1::MealsController < ApplicationController

  def index
    @meals = Meal.all
    render json: @meals, status: :ok
  end

def show
  @meal = Meals.find(params[:id])
  render json: @meals, status: :ok
end

def create
  if current_user.admin?
  @meal =Meal.new(meal_params)
  if @meal.save
  render json: @meals, status: :ok
  else
    render json: {}
  end
end
end

def destroy
  if current_user.admin?
  @meal = Meals.find(params[:id])
  if @meals.destroy
    head :no_content
  end
  end
end

  private



  def meal_params
    params.require(:meals).permit(:name, :description, :price, :available, :photo)
  end
end
