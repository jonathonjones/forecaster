require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forecasts_index_url
    assert_response :success
  end

  test "can post to index" do
    post forecasts_index_url, params: {zip_code: "12345"}
    assert_response :success
  end
end
