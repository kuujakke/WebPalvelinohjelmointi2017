require 'rails_helper'

describe "Beers page" do
  let!(:brewery) { brewery = FactoryGirl.create :brewery }
  describe "create new beer" do
    before :each do
      visit new_beer_path
    end
    it "should save a valid beer" do
      fill_in('beer[name]', with:'Nikolai')
      select(brewery.name, from: 'beer_brewery_id')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end
    it "should not save beer with a blank name" do
      expect{
        click_button('Create Beer')
      }.not_to change{Beer.count}
      expect(page).to have_content "Name can't be blank"
    end
  end
end
