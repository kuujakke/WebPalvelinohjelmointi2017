require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
  describe "who has ratings" do
    before :each do
      create_beers_with_ratings(@user, 10, 11, 13)
      sign_in(username:"Pekka", password:"Foobar1")
    end
    it "should show ratings count correctly" do
      visit user_path(@user)
      expect(page).to have_content "Has made 3 ratings"
    end
    it "should show ratings average correctly" do
      visit user_path(@user)
      expect(page).to have_content "average 11.33"
    end
    it "should only count own ratings" do
      other_user = FactoryGirl.create :user, username: "Other"
      create_beer_with_rating(other_user, 50)
      visit user_path(@user)
      expect(page).to have_content "Has made 3 ratings, average 11.33"
    end
    it "should be able to remove own ratings" do
      visit user_path(@user)
      expect{
        page.first(:link, 'delete').click
      }.to change{Rating.count}.from(3).to(2)
    end
    describe "has data about" do
      it "favorite beer" do
        expect(page).to have_content "Favorite beer: Öl"
      end
      it "favorite style" do
        expect(page).to have_content "Favorite style: Pohjasakka"
      end
      it "favorite brewery" do
        expect(page).to have_content "Favorite brewery: Bruuweri"
      end
    end
  end
end