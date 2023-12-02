class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.time :reserve_time
      t.integer :quantity
      t.string :spicy_level

      t.timestamps
    end
  end
end
