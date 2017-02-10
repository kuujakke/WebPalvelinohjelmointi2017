require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "is not saved with invalid password" do
    it "when too short" do
      user = User.create username: "Pekka", password: "asd", password_confirmation: "asd"
      expect(user).not_to be_valid
    end
    it "when not containing a number" do
      user = User.create username: "Pekka", password: "asdAsd", password_confirmation: "asdAsd"
      expect(user).not_to be_valid
    end
    it "when not containing a capital letter" do
      user = User.create username: "Pekka", password: "asd1asd", password_confirmation: "asd1ad"

    end
  end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      Brewery.create name: "ok", year: 1994
      beer = Beer.create name: "ok", style: "ok", brewery: Brewery.first
      user = User.create username: "oasdasdasdk", password: "Aasdasd2", password_confirmation: "Aasdasd2"
      Rating.create score: 10, beer: beer, user: user
      Rating.create score: 20, beer: beer, user: user
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end
