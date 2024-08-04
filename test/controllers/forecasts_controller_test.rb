require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forecasts_index_url
    assert_response :success
  end

  test "can post to index" do
    VCR.use_cassette(method_name) do
      post forecasts_index_url, params: {address: "12345"}
      assert_response :success
    end
  end

  test "address should fetch address from params" do
    VCR.use_cassette(method_name) do
      post forecasts_index_url, params: {address: "12345"}
      assert_equal "12345", @controller.helpers.address
    end
  end

  test "current_temperature can be fetched" do
    VCR.use_cassette(method_name) do
      post forecasts_index_url, params: {address: "1600 Pennsylvania Ave NW Washington, DC"}
      assert_equal 75.4, @controller.helpers.current_temperature
    end
  end

  test "extended_forecast is an array of hashes of dates, highs, and lows" do
    VCR.use_cassette(method_name) do
      post forecasts_index_url, params: {address: "1600 Pennsylvania Ave NW Washington, DC"}
      expected =
        [
          {date: "2024-08-04", high: 88.0, low: 73.1},
          {date: "2024-08-05", high: 101.0, low: 70.9},
          {date: "2024-08-06", high: 97.8, low: 76.3},
          {date: "2024-08-07", high: 82.8, low: 70.6},
          {date: "2024-08-08", high: 88.0, low: 72.6},
          {date: "2024-08-09", high: 86.3, low: 76.2},
          {date: "2024-08-10", high: 78.7, low: 63.5}
        ]
      assert_equal expected, @controller.helpers.extended_forecast
    end
  end
end
