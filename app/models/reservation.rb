class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validates :reserve_time, :reserve_date, :quantity, :spicy_level, presence: true
end
