class Geocode
  attr_reader :address

  def initialize(address:)
    @address = address
  end

  def any?
    data.any?
  end

  def data
    @data ||= fetch
  end

  # See https://nominatim.org/release-docs/develop/api/Search/
  def fetch
    address_component = URI.encode_www_form_component(address)
    uri = URI.parse("https://nominatim.openstreetmap.org/search.php?q=#{address_component}&format=jsonv2&addressdetails=1")
    JSON.parse(Net::HTTP.get(uri, {Referer: "Forecasts Toy Project"}))
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
end
