class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self
  has_many :meals, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
