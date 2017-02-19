require 'beermapping_api'
require 'apixu_api'

class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @city = params[:city]
      @weather_icon = ApixuApi.condition_in(params[:city])
      @temperature = ApixuApi.temperature_in(params[:city])
      @wind = ApixuApi.wind_in(params[:city])
      render :index
    end
  end

  def show
    @place = BeermappingApi.place(params[:id])
    @key = maps_key
    if @place.empty?
      redirect_to places_path, notice: "No location with id #{params[:id]}"
    else
      render :show
    end
  end

  def maps_key
    raise "MAPSKEY env variable not defined" if ENV['MAPSKEY'].nil?
    ENV['MAPSKEY']
  end

  def maps_query
  end

end