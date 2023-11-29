class Reservation < ApplicationRecord
  belongs_to :users
  belongs_to :flights
end
