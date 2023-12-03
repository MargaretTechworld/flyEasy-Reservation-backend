class AddDefaultToAvailableInMeals < ActiveRecord::Migration[7.1]
  def change
    change_column_default :meals, :available, from: nil, to: false
  end
end
