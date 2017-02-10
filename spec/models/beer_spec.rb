require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:brewery){ Brewery.create name:"Bruuweri", year:1989}
  describe "with valid parameters" do
    let(:beer){Beer.create name:"Bruuveri", style:"Hiano", brewery: brewery}

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
      beer = Beer.create style: "Huono", brewery: brewery
      expect(beer).to_not be_valid
    end
    it "when brewery is missing" do
      beer = Beer.create name: "Brewsky", style: "Huono"
      expect(beer).to_not be_valid
    end
  end
end
