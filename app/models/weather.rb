# Weather gets the current temperature and highs and lows for the next several days
# for a particular latitude and longitude.
class Weather
  attr_reader :latitude, :longitude

  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  # Data comes in as
  # "current"=>{"time"=>"2024-08-04T02:30", "interval"=>900, "temperature_2m"=>55.2}
  # returns Float as degrees Fahrenheit
  def current_temperature
    data["current"]["temperature_2m"]
  end

  # Data comes in as
  # "daily"=>{"time"=>["2024-08-04", ...], "temperature_2m_max"=>[91.1, ...], "temperature_2m_min"=>[70.0, ...]}}
  # returns an Array of Hashes
  # example: [{date: "2024-08-04", high: 91.1, low: 70.0}]
  def extended_forecast
    daily = data["daily"]
    daily["time"].map.with_index do |date, index|
      {date: date, high: daily["temperature_2m_max"][index], low: daily["temperature_2m_min"][index]}
    end
  end

  private

  def data
    @data ||= fetch
  end

  # See https://open-meteo.com/en/docs
  # temperature_2m refers to the temperature at 2 meters off the ground
  # temperature_2m_max is the high temperature for a date at 2 meters off the ground
  # temperature_2m_min is the low temperature for a date at 2 meters off the ground
  def fetch
    uri = URI.parse("https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m&format=json&temperature_unit=fahrenheit&daily=temperature_2m_max,temperature_2m_min")
    JSON.parse(Net::HTTP.get(uri, {Referer: "Forecasts Toy Project"}))
  end
end
