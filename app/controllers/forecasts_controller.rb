class ForecastsController < ApplicationController
  require "net/http"

  def index
  end

  private

  def address
    @address ||= params[:address]
  end
  helper_method :address

  # Data comes in as
  # "current"=>{"time"=>"2024-08-04T02:30", "interval"=>900, "temperature_2m"=>55.2}
  def current_temperature
    weather["current"]["temperature_2m"]
  end
  helper_method :current_temperature

  # Data comes in as
  # "daily"=>{"time"=>["2024-08-04", ...], "temperature_2m_max"=>[91.1, ...], "temperature_2m_min"=>[70.0, ...]}}
  def extended_forecast
    daily = weather["daily"]
    daily["time"].map.with_index do |date, index|
      {date: date, high: daily["temperature_2m_max"][index], low: daily["temperature_2m_min"][index]}
    end
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

  # See https://open-meteo.com/en/docs
  def fetch_weather
    Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      Weather.new(latitude:, longitude:).fetch
    end
  end  

  def latitude
    geocode_data.first["lat"]
  end

  def longitude
    geocode_data.first["lon"]
  end

  def weather
    @weather ||= fetch_weather
  end
end
