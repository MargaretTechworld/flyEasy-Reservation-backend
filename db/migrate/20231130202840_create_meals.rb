class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale:2
      t.boolean :available
      t.text :photo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
