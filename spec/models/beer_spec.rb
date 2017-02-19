require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:brewery){ Brewery.create name:"Bruuweri", year:1989}
  let!(:style){ FactoryGirl.create(:style)}
  describe "with valid parameters" do
    let(:beer){Beer.create name:"Bruuveri", style:style, brewery: brewery}

    it "is saved" do
      expect(beer).to be_valid
    end
  end
  describe "with invalid parameters is not saved" do
    it "when style is missing" do
      beer = Beer.create name:"Bruuvier", brewery: brewery
      expect(beer).to_not be_valid
    end
    it "when name is missing" do
      beer = Beer.create style: style, brewery: brewery
      expect(beer).to_not be_valid
    end
    it "when brewery is missing" do
      beer = Beer.create name: "Brewsky", style: style
      expect(beer).to_not be_valid
    end
  end
end
