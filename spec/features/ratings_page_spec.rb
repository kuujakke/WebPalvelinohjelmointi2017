require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "listing" do
    before :each do
      visit ratings_path
    end
    describe "when there is no ratings" do
      it "should not show ratings count" do
        expect(page).not_to have_content "Number of ratings:"
      end
    end
    describe "when ratings exist" do
      let!(:rating1) { FactoryGirl.create :rating, score: 10, beer: beer1, user: user }
      let!(:rating2) { FactoryGirl.create :rating, score: 15, beer: beer2, user: user }

      it "should contain the number of ratings" do
        visit ratings_path
        expect(page).to have_content "Total number of ratings: 2"
      end
    end
  end
end