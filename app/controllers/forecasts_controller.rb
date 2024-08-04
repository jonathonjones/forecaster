class ForecastsController < ApplicationController
  require "net/http"

  def index
  end

  private

  def address
    @address ||= params[:address]
  end
  helper_method :address

  # returns Float as degrees Fahrenheit
  def current_temperature
    weather.current_temperature
  end
  helper_method :current_temperature

  # Highs and Lows for the next several days, including today
  # returns an Array of Hashes
  # example: [{date: "2024-08-04", high: 91.1, low: 70.0}]
  def extended_forecast
    weather.extended_forecast
  end
  helper_method :extended_forecast

  def fetched_from_cache?
    Rails.cache.read(cache_key).present?
  end
  helper_method :fetched_from_cache?

  def geocode_data
    @geocode_data ||= fetch_geocode_data
  end
  helper_method :geocode_data

  def zipcode
    geocode_data.first["address"]["postcode"]
  end
  helper_method :zipcode

  def cache_key
    "zipcode#{zipcode}"
  end

  # See https://nominatim.org/release-docs/develop/api/Search/
  def fetch_geocode_data
    address_component = URI.encode_www_form_component(address)
    uri = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{address_component}&format=jsonv2&addressdetails=1")
    JSON.parse(Net::HTTP.get(uri, {Referer: "Forecasts Toy Project"}))
  end

  def latitude
    geocode_data.first["lat"]
  end

  def longitude
    geocode_data.first["lon"]
  end

  # See https://open-meteo.com/en/docs
  def weather
    @weather ||= Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      Weather.new(latitude:, longitude:)
    end
  end
end
