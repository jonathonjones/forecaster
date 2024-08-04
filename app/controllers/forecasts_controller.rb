class ForecastsController < ApplicationController
  require 'net/http'

  def index
  end

  private

  def current_temperature
    weather['current']['temperature_2m']
  end
  helper_method :current_temperature

  # Data comes in as "daily"=>{"time"=>["2024-08-04", "2024-08-05", "2024-08-06", "2024-08-07", "2024-08-08", "2024-08-09", "2024-08-10"], "temperature_2m_max"=>[91.1, 91.8, 90.6, 83.1, 87.0, 85.3, 81.9], "temperature_2m_min"=>[70.0, 70.3, 70.3, 70.8, 66.3, 67.3, 62.3]}}
  def extended_forecast
    daily = weather['daily']
    daily['time'].map.with_index do |date, index|
      {date: date, high: daily['temperature_2m_max'][index], low: daily['temperature_2m_min'][index]}
    end
  end
  helper_method :extended_forecast

  def address
    @address ||= params[:address]
  end
  helper_method :address

  def geocode_data
    @geocode_data ||= fetch_geocode_data
  end

  def fetch_geocode_data
    address_component = URI.encode_www_form_component(address)
    uri = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{address_component}&format=jsonv2")
    JSON.parse(Net::HTTP.get(uri, {Referer: 'Forecasts Toy Project'}))
  end

  def latitude
    geocode_data.first['lat']
  end

  def longitude
    geocode_data.first['lon']
  end

  def weather
    @weather ||= fetch_weather
  end

  def fetch_weather
    uri = URI.parse("https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m&format=json&temperature_unit=fahrenheit&daily=temperature_2m_max,temperature_2m_min")
    JSON.parse(Net::HTTP.get(uri, {Referer: 'Forecasts Toy Project'}))
  end
end
