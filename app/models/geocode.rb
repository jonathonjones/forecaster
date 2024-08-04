class Geocode
  attr_reader :address

  def initialize(address:)
    @address = address
  end

  def any?
    data.any?
  end

  def latitude
    data.first["lat"]
  end

  def longitude
    data.first["lon"]
  end

  def zipcode
    data.first["address"]["postcode"]
  end

  private

  def data
    @data ||= fetch
  end

  # See https://nominatim.org/release-docs/develop/api/Search/
  # Geocode data is formatted as follows:
  # [{"place_id"=>18065671, "licence"=>"Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright", "osm_type"=>"relation", "osm_id"=>9671540, "lat"=>"42.345695750000004", "lon"=>"-71.11946084959486", "category"=>"building", "type"=>"yes", "place_rank"=>30, "importance"=>9.99999999995449e-06, "addresstype"=>"building", "name"=>"", "display_name"=>"84, Browne Street, North Brookline, Brookline, Norfolk County, Massachusetts, 02446, United States", "address"=>{"house_number"=>"84", "road"=>"Browne Street", "neighbourhood"=>"North Brookline", "town"=>"Brookline", "county"=>"Norfolk County", "state"=>"Massachusetts", "ISO3166-2-lvl4"=>"US-MA", "postcode"=>"02446", "country"=>"United States", "country_code"=>"us"}, "boundingbox"=>["42.3455657", "42.3457554", "-71.1195458", "-71.1193964"]}]
  def fetch
    address_component = URI.encode_www_form_component(address)
    uri = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{address_component}&format=jsonv2&addressdetails=1")
    JSON.parse(Net::HTTP.get(uri, {Referer: "Forecasts Toy Project"}))
  end
end
