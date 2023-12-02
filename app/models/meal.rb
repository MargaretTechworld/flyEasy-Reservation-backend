class Meal < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :name, :price, :photo, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
