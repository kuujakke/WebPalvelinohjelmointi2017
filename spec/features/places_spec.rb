require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1)]
    )
    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(apixu_mock)

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
  end
  it "if API returns many, each is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi1", id: 1), Place.new(name: "Oljenkorsi2", id: 2)]
    )
    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(apixu_mock)
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi1" and "Oljenkorsi2"
  end
  it "if nothing is returned by the API, a 'no locations in...' message is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"
  end
  def apixu_mock
    {"location" =>
         {"name" => "Helsinki",
          "region" => "Southern Finland",
          "country" => "Finland",
          "lat" => 60.18,
          "lon" => 24.93,
          "tz_id" => "Europe/Helsinki",
          "localtime_epoch" => 1487539810,
          "localtime" => "2017-02-19 21:30"},
     "current" =>
         {"last_updated_epoch" => 1487539810,
          "last_updated" => "2017-02-19 21:30",
          "temp_c" => 3.0,
          "temp_f" => 37.4,
          "is_day" => 0,
          "condition" => {"text" => "Partly cloudy", "icon" => "//cdn.apixu.com/weather/64x64/night/116.png", "code" => 1003},
          "wind_mph" => 9.4,
          "wind_kph" => 15.1,
          "wind_degree" => 210,
          "wind_dir" => "SSW",
          "pressure_mb" => 992.0,
          "pressure_in" => 29.8,
          "precip_mm" => 0.1,
          "precip_in" => 0.0,
          "humidity" => 93,
          "cloud" => 0,
          "feelslike_c" => -0.7,
          "feelslike_f" => 30.7,
          "vis_km" => 10.0,
          "vis_miles" => 6.0}}
  end
end