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

- There should be a front-end for all of this (not purely an API)
- It is better to do this with minimal dependencies.
- - Therefore, I did not use projects like https://github.com/t27duck/weatherboy.
- - Similarly, I limited installation of rails (rails new --minimal --without-activerecord)
