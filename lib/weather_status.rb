require 'rest-client'
require 'json'

class WeatherStatus
  BASE_URL = 'http://dataservice.accuweather.com/currentconditions/v1/28580/historical/24'

  def initialize(weather_api_key)
    @weather_api_key = weather_api_key
  end

  def weather
    begin
      response = RestClient.get(BASE_URL, headers)
      JSON.parse(response.body) if response.code == 200
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  private

  def headers
    {
        params: { apikey: @weather_api_key.to_s }, 
        content_type: :json, 
        accept: :json
    }
  end
end
