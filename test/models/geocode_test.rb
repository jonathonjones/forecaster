require "test_helper"

class GeocodeTest < ActiveSupport::TestCase
  test "can fetch geocode for an address" do
    VCR.use_cassette(method_name) do
      geocode = Geocode.new(address: "1600 Pennsylvania Ave NW Washington, DC")
      expected =
        [
          {
            "place_id" => 4230080,
            "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
            "osm_type" => "way",
            "osm_id" => 238241022,
            "lat" => "38.897699700000004",
            "lon" => "-77.03655315",
            "category" => "office",
            "type" => "government",
            "place_rank" => 30,
            "importance" => 0.6347211541681101,
            "addresstype" => "office",
            "name" => "White House",
            "display_name" => "White House, 1600, Pennsylvania Avenue Northwest, Ward 2, Washington, District of Columbia, 20500, United States",
            "address" =>
              {
                "office" => "White House",
                "house_number" => "1600",
                "road" => "Pennsylvania Avenue Northwest",
                "borough" => "Ward 2",
                "city" => "Washington",
                "state" => "District of Columbia",
                "ISO3166-2-lvl4" => "US-DC",
                "postcode" => "20500",
                "country" => "United States",
                "country_code" => "us"
              },
            "boundingbox" => ["38.8974908", "38.8979110", "-77.0368537", "-77.0362519"]
          },
          {
            "place_id" => 4208793,
            "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
            "osm_type" => "way",
            "osm_id" => 238241023,
            "lat" => "38.89737555",
            "lon" => "-77.0374079114865",
            "category" => "office",
            "type" => "government",
            "place_rank" => 30,
            "importance" => 0.4809695871239888,
            "addresstype" => "office",
            "name" => "The Oval Office",
            "display_name" => "The Oval Office, 1600, Pennsylvania Avenue Northwest, Ward 2, Washington, District of Columbia, 20006, United States",
            "address" =>
              {
                "office" => "The Oval Office",
                "house_number" => "1600",
                "road" => "Pennsylvania Avenue Northwest",
                "borough" => "Ward 2",
                "city" => "Washington",
                "state" => "District of Columbia",
                "ISO3166-2-lvl4" => "US-DC",
                "postcode" => "20006",
                "country" => "United States",
                "country_code" => "us"
              },
            "boundingbox" => ["38.8973242", "38.8974297", "-77.0374621", "-77.0373535"]
          },
          {
            "place_id" => 4222732,
            "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
            "osm_type" => "way",
            "osm_id" => 238241016,
            "lat" => "38.89751125",
            "lon" => "-77.03755907267006",
            "category" => "building",
            "type" => "yes",
            "place_rank" => 30,
            "importance" => 0.4055805794353464,
            "addresstype" => "building",
            "name" => "The West Wing",
            "display_name" => "The West Wing, 1600, Pennsylvania Avenue Northwest, Ward 2, Washington, District of Columbia, 20500, United States",
            "address" =>
              {
                "building" => "The West Wing",
                "house_number" => "1600",
                "road" => "Pennsylvania Avenue Northwest",
                "borough" => "Ward 2",
                "city" => "Washington",
                "state" => "District of Columbia",
                "ISO3166-2-lvl4" => "US-DC",
                "postcode" => "20500",
                "country" => "United States",
                "country_code" => "us"
              }, "boundingbox" => ["38.8973242", "38.8976897", "-77.0378226", "-77.0372952"]
          },
          {
            "place_id" => 393877249,
            "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
            "osm_type" => "way",
            "osm_id" => 238241018,
            "lat" => "38.89757375",
            "lon" => "-77.03564283145161",
            "category" => "building",
            "type" => "government",
            "place_rank" => 30,
            "importance" => 0.3050039459623188,
            "addresstype" => "building",
            "name" => "The East Wing",
            "display_name" => "The East Wing, 1600, Pennsylvania Avenue Northwest, Ward 2, Washington, District of Columbia, 20500, United States",
            "address" =>
              {
                "building" => "The East Wing",
                "house_number" => "1600",
                "road" => "Pennsylvania Avenue Northwest",
                "borough" => "Ward 2",
                "city" => "Washington",
                "state" => "District of Columbia",
                "ISO3166-2-lvl4" => "US-DC",
                "postcode" => "20500",
                "country" => "United States",
                "country_code" => "us"
              },
            "boundingbox" => ["38.8973817", "38.8977680", "-77.0357843", "-77.0355017"]
          }
        ]
      assert_equal expected, geocode.send(:fetch)
    end
  end

  test "can fetch latitude for a location" do
    VCR.use_cassette(method_name) do
      geocode = Geocode.new(address: "1600 Pennsylvania Ave NW Washington, DC")
      assert_equal "38.897699700000004", geocode.latitude
    end
  end

  test "can fetch longitude for a location" do
    VCR.use_cassette(method_name) do
      geocode = Geocode.new(address: "1600 Pennsylvania Ave NW Washington, DC")
      assert_equal "-77.03655315", geocode.longitude
    end
  end

  test "can fetch zipcdoe for a location" do
    VCR.use_cassette(method_name) do
      geocode = Geocode.new(address: "1600 Pennsylvania Ave NW Washington, DC")
      assert_equal "20500", geocode.zipcode
    end
  end
end
