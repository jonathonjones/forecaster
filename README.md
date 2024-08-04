# forecaster

Pulls weather data to make a forecast for a particular location, part of a code test

## Requirements

- Accept an address as input
- Retrieve forecast data for the given address. This should include, at minimum, the
  current temperature (Bonus points - Retrieve high/low and/or extended forecast)
- Display the requested forecast details to the user
- Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
- Display indicator if result is pulled from cache.

## My Assumptions

- There should be a front-end for all of this
- It is better to do this with minimal dependencies.
- - Therefore, I did not use projects like <https://github.com/t27duck/weatherboy>.
- - Similarly, I limited installation of rails (rails new --minimal --without-activerecord)

## Details on Data

- The geocode data comes in the following format:

    [{"place_id"=>18065671, "licence"=>"Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright", "osm_type"=>"relation", "osm_id"=>9671540, "lat"=>"42.345695750000004", "lon"=>"-71.11946084959486", "category"=>"building", "type"=>"yes", "place_rank"=>30, "importance"=>9.99999999995449e-06, "addresstype"=>"building", "name"=>"", "display_name"=>"84, Browne Street, North Brookline, Brookline, Norfolk County, Massachusetts, 02446, United States", "address"=>{"house_number"=>"84", "road"=>"Browne Street", "neighbourhood"=>"North Brookline", "town"=>"Brookline", "county"=>"Norfolk County", "state"=>"Massachusetts", "ISO3166-2-lvl4"=>"US-MA", "postcode"=>"02446", "country"=>"United States", "country_code"=>"us"}, "boundingbox"=>["42.3455657", "42.3457554", "-71.1195458", "-71.1193964"]}]

- The weather data looks like this:

    {"latitude"=>42.34697, "longitude"=>-71.107056, "generationtime_ms"=>0.051975250244140625, "utc_offset_seconds"=>0, "timezone"=>"GMT", "timezone_abbreviation"=>"GMT", "elevation"=>24.0, "current_units"=>{"time"=>"iso8601", "interval"=>"seconds", "temperature_2m"=>"°F"}, "current"=>{"time"=>"2024-08-04T03:45", "interval"=>900, "temperature_2m"=>77.7}, "daily_units"=>{"time"=>"iso8601", "temperature_2m_max"=>"°F", "temperature_2m_min"=>"°F"}, "daily"=>{"time"=>["2024-08-04", "2024-08-05", "2024-08-06", "2024-08-07", "2024-08-08", "2024-08-09", "2024-08-10"], "temperature_2m_max"=>[87.4, 94.3, 74.5, 68.9, 74.0, 73.1, 66.4], "temperature_2m_min"=>[74.8, 69.8, 65.1, 59.9, 58.1, 66.5, 61.8]}}

## Notes

- Rails caching is off in development, so to see the caching behavior run 'rails dev:cache' to toggle caching.
- Basic styling is provided by <https://picocss.com/docs>
