class AlterTableReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :reserve_date, :date
  end
end
