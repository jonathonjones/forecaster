class ForecastsController < ApplicationController
  def index
  end

  private

  def address
    @address ||= params[:address]
  end
  helper_method :address

  def any_geocode_data?
    geocode_data.any?
  end
  helper_method :any_geocode_data?

  # returns Float for degrees Fahrenheit
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

  def zipcode
    geocode_data.zipcode
  end
  helper_method :zipcode

  def cache_key
    "zipcode#{zipcode}"
  end

  def geocode_data
    @geocode_data ||= Geocode.new(address:)
  end

  def latitude
    geocode_data.latitude
  end

  def longitude
    geocode_data.longitude
  end

  # See https://open-meteo.com/en/docs
  def weather
    @weather ||= Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      Weather.new(latitude:, longitude:)
    end
  end
end
