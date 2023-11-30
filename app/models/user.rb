class User < ApplicationRecord
  has_many :reservations
  has_many :meals, through: :reservations
end
