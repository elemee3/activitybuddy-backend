require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', city: 'san diego', state: 'ca', zipcode: 12345) }


  describe "#display_address" do
    it "should display address1 and city" do
      expect(user.display_address(user)).to eq("123 street1, san diego")
    end

    it "should display address1 without city or blank padding" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', city: '', state: 'ca', zipcode: 12345)
      expect(user.display_address(user)).to eq("123 street1")
    end

    it "should display email if address1 and city are blank" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '', city: '', state: 'ca', zipcode: 12345)
      expect(user.display_address(user)).to eq("123@g.com")
    end
  end


  describe "user validations" do
    it "creates a user" do
      expect{User.new}.to_not raise_error
      expect(User.new).to be_a User
    end

    it "is valid with valid attributes" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', city: 'san diego', state: 'ca', zipcode: 12345)
      expect(user).to be_valid
    end

    it "is not valid without an address1" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', city: 'san diego', state: 'ca', zipcode: 12345)
      expect(user).to_not be_valid
    end

    it "is not valid without a city" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', state: 'ca', zipcode: 12345)
      expect(user).to_not be_valid
    end

    it "is not valid without a state" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', city: 'san diego', zipcode: 12345)
      expect(user).to_not be_valid
    end

    it "is not valid without a zipcode" do
      user = User.new(email: '123@g.com', password: '123456', password_confirmation: '123456', address1: '123 street1', city: 'san diego', state: 'ca')
      expect(user).to_not be_valid
    end

    it "is not valid without an email" do
      user = User.new(password: '123456', password_confirmation: '123456', address1: '123 street1', city: 'san diego', state: 'ca', zipcode: 12345)
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user = User.new(email: '123@g.com', address1: '123 street1', city: 'san diego', state: 'ca', zipcode: 12345)
      expect(user).to_not be_valid
    end
  end

end
