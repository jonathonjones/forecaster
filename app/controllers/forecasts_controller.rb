class ForecastsController < ApplicationController
  require 'net/http'

  def index
  end

  private

  def address
    @address ||= params[:address]
  end
  helper_method :address

  def geocode_data
    @geocode_data ||= fetch_geocode_data!
  end

  def fetch_geocode_data!
    address_component = URI.encode_www_form_component(address)
    uri = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{address_component}&format=jsonv2")
    JSON.parse(Net::HTTP.get(uri, {Referer: 'Forecasts Toy Project'}))
  end

  def latitude
    geocode_data.first['lat']
  end
  helper_method :latitude

  def longitude
    geocode_data.first['lon']
  end
  helper_method :longitude

  def weather

  end
end
