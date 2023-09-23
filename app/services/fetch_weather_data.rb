require 'weather_status'

class FetchWeatherData
  class << self
    def call
      create_weather_status
    end

    private

    def response
      @response = WeatherStatus.new(Rails.application.credentials.weather_api_key)
    end

    def create_weather_status
      response.weather.each do |data|
        datetime = data['EpochTime']
        temperature = data.dig('Temperature', 'Metric', 'Value')
        WeatherDatum.find_or_create_by!(datetime: datetime, temperature:temperature)
      end
    end
  end
end
