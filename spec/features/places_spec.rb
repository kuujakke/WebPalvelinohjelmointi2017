require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
  end
  it "if API returns many, each is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi1", id: 1 ), Place.new( name:"Oljenkorsi2", id: 2 ) ]
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi1" and "Oljenkorsi2"
  end
  it "if nothing is returned by the API, a 'no locations in...' message is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return( [ ] )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"
  end
end