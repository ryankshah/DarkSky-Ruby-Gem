# Uses the geocoder gem for location lat/long
require 'geocoder'
# Uses the net/http gem for stability over speed
# Maybe this can be improved upon in later revisions
require 'net/http'
# Uses the json gem for parsing request results
require 'json'

# No support for languages yet
class DarkSky
	def initialize(key, location)
		@key = key
		@location = location

		configure()
	end

	def configure()
		@units = 'auto'
		@coordinates = Geocoder.coordinates(@location) # tuple of latitude and longitude
		@request_url = "https://api.darksky.net/forecast/#{@key}/#{@coordinates[0]},#{@coordinates[1]}?units=#{@units}";
	end

	def getWeatherAlerts()
		requestTemp = @request_url + '&exclude=[currently,minutely,hourly,daily,flags]'
		result = makeRequest(requestTemp)
	end

	def setLocation(location)
		@location = location
		configure() # have to reconfigure the @request_url
	end

	def makeRequest(url)
		uri = URI(url)
		response = Net::HTTP.get(uri)
		return JSON.parse(response)
	end

	def getLocation
		return @location
	end
	def getUnits
		return @units
	end
end
