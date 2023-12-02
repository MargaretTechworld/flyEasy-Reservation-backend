# meals_controller.rb
class Api::V1::MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: %i[create destroy meals_available update_availability]

  def index
    @meals = Meal.where(available: true).order('created_at desc')
    render json: @meals, status: :ok
  end

  def meals_available
    @meals = current_user.meals.order(created_at: :desc)
    render json: @meals, status: :ok
  end

  def show
    @meal = Meal.find(params[:id])
    render json: @meal, status: :ok
  end

  def create
    @meal = current_user.meals.new(meal_params)
    if @meal.save
      render json: @meal, status: :created
    else
      render json: { errors: @meal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = current_user.meals.find(params[:id])
    if @meal.destroy
      head :no_content
    else
      render json: { errors: 'Failed to destroy meal' }, status: :unprocessable_entity
    end
  end

  def update_availability
    @meal = current_user.meals.find(params[:id])
    if @meal.update(available: !@meal.available)
      render json: { message: 'Availability updated successuflly', available: @meal.available }
    else
      render json: @meal.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :price, :available, :photo)
  end

  def check_admin
    return if current_user.admin?

    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
