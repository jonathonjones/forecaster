class Weather < Data.define(:latitude, :longitude)
  def fetch
    uri = URI.parse("https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m&format=json&temperature_unit=fahrenheit&daily=temperature_2m_max,temperature_2m_min")
    JSON.parse(Net::HTTP.get(uri, {Referer: "Forecasts Toy Project"}))
  end
end