require 'rails_helper'

RSpec.describe Meal, type: :model do
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
  before {user.save}
  before {meal.save}
context 'validity'do
  it 'is valid with valid attributes' do
    expect(meal).to be_valid
  end
  it 'is not valid without meal name' do
    expect(meal.name).to eq('rice')
  end
  it 'shows the exact meal description' do
    expect(meal.description).to eq('this is chinese rice and sauce')
  end
  it 'shows the exact meal price' do
    expect(meal.price).to eq(200)
  end
  it 'shows the exact meal photo' do
    expect(meal.photo).to eq('image1.jpg')
  end
end
context 'invialidity:' do
  it 'is not valid when name is not present' do
    meal.name = nil
    expect(meal).not_to be_valid
  end
  it 'is not valid when price is not present' do
    meal.price = nil
    expect(meal).not_to be_valid
  end
  it 'is not valid when photo is not present' do
    meal.photo = nil
    expect(meal).not_to be_valid
  end
end
end
