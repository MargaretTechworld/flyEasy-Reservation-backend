require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) {
    User.new(
      name: 'Ghost',
      email: 'ghost@gmail.com',
      password: '1234567',
      password_confirmation: '1234567'
    )
  }
  let(:meal) {
    Meal.new(
      name: 'rice',
      description: 'this is chinese rice and sauce',
      price: 200,
      photo: 'image1.jpg',
      user: user
    )
  }
  let(:reservation) {
    Reservation.new(
      reserve_time: '14:15',
      quantity: 20,
      spicy_level: 'hot',
      reserve_date: '14-02-2023', 
      user: user,
      meal: meal
    )
}
  before {reservation.save}
  before {user.save}
  before {meal.save}
context 'validity'do
  it 'is valid with valid attributes' do
    expect(reservation).to be_valid
  end
  it 'is not valid without reservation time' do
    expect(reservation.reserve_time.strftime('%H:%M')).to eq('14:15')
  end
  it 'shows the exact reservation date' do
    expect(reservation.reserve_date.strftime('%d-%m-%Y')).to eq('14-02-2023')
  end
  it 'shows the exact reservation quantity' do
    expect(reservation.quantity).to eq(20)
  end
  it 'shows the exact reservation spicy level' do
    expect(reservation.spicy_level).to eq('hot')
  end
end
context 'invalidity:' do
  it 'is not valid when time is not present' do
    reservation.reserve_time = nil
    expect(reservation).not_to be_valid
  end
  it 'is not valid when date is not present' do
    reservation.reserve_date = nil
    expect(reservation).not_to be_valid
  end
  it 'is not valid when quantity is not present' do
    reservation.quantity = nil
    expect(reservation).not_to be_valid
  end
  it 'is not valid when spicy-level is not present' do
    reservation.spicy_level = nil
    expect(reservation).not_to be_valid
  end
end
end
