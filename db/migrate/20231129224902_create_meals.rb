class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :description
      t.string :available
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
