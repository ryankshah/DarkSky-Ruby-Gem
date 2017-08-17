# Uses the geocoder gem for location lat/long
require 'geocoder'
# Uses the net/http gem for api requests
require 'httparty'
# Uses the json gem for parsing request results
require 'json'

# No support for languages yet
class DarkSky
	def initialize(key, location)
		@key = key
		@location = location

		# Configure units, coordinates (Geocoder) and request_url
		configure()
	end

	def configure()
		@units = 'auto'
		@coordinates = Geocoder.coordinates @location # Tuple of latitude and longitude
		@request_url = "https://api.darksky.net/forecast/#{@key}/#{@coordinates[0]},#{@coordinates[1]}?units=#{@units}";
	end

	def getCurrentWeather()
		requestTemp = @request_url + '&exclude=[minutely,hourly,daily,flags,alerts]'
		result = makeRequest requestTemp
		puts result
	end

	def setLocation(location)
		@location = location
		configure() # have to reconfigure the @request_url
	end

	def makeRequest(url)
		response = HTTParty.get url, verify: false # Dont need SSL certificate (better way than using HTTParty?)
		return JSON.parse response.body, symbolize_names:true # Return a Hash of the JSON result
	end

	# Utilities
	def getLocation
		return @location
	end
	def getUnits
		return @units
	end
end
