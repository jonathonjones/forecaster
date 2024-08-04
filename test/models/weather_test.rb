require "test_helper"

class WeatherTest < ActiveSupport::TestCase
  test "can fetch weather for a location" do
    VCR.use_cassette(method_name) do
      weather = Weather.new(latitude: "42.345695750000004", longitude: "-71.11946084959486")
      expected =
        {
          "latitude" => 42.34697,
          "longitude" => -71.107056,
          "generationtime_ms" => 0.051021575927734375,
          "utc_offset_seconds" => 0,
          "timezone" => "GMT",
          "timezone_abbreviation" => "GMT",
          "elevation" => 24.0,
          "current_units" => {"time" => "iso8601", "interval" => "seconds", "temperature_2m" => "°F"},
          "current" => {"time" => "2024-08-04T04:15", "interval" => 900, "temperature_2m" => 77.0},
          "daily_units" => {"time" => "iso8601", "temperature_2m_max" => "°F", "temperature_2m_min" => "°F"},
          "daily" => {
            "time" => ["2024-08-04", "2024-08-05", "2024-08-06", "2024-08-07", "2024-08-08", "2024-08-09", "2024-08-10"],
            "temperature_2m_max" => [87.4, 94.3, 78.3, 69.5, 74.1, 84.0, 79.9],
            "temperature_2m_min" => [74.8, 69.8, 62.6, 59.4, 56.7, 63.1, 65.3]
          }
        }
      assert_equal expected, weather.fetch
    end
  end

  test "returns current_temperature as a Float in degrees Fahrenheit" do
    VCR.use_cassette(method_name) do
      weather = Weather.new(latitude: "42.345695750000004", longitude: "-71.11946084959486")
      assert_equal 76.6, weather.current_temperature
    end
  end

  test "returns extended_forecast as an Array of Hashes of dates, highs, and lows" do
    VCR.use_cassette(method_name) do
      weather = Weather.new(latitude: "42.345695750000004", longitude: "-71.11946084959486")
      expected =
        [
          {date: "2024-08-04", high: 87.4, low: 74.8},
          {date: "2024-08-05", high: 94.3, low: 69.8},
          {date: "2024-08-06", high: 78.3, low: 62.6},
          {date: "2024-08-07", high: 69.5, low: 59.4},
          {date: "2024-08-08", high: 74.1, low: 56.7},
          {date: "2024-08-09", high: 84.0, low: 63.1},
          {date: "2024-08-10", high: 79.9, low: 65.3}
        ]
      assert_equal expected, weather.extended_forecast
    end
  end
end
