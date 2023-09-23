class Weather < Grape::API
  prefix :weather
  format :json

  helpers do
    def get_weather_for_last_24_hours
      WeatherDatum.where('datetime >= ? and datetime <= ?', Time.now.to_i - (60 * 60 * 24), Time.now.to_i)
    end
  end

  desc 'returns current temperature'
  get "/current" do
    WeatherDatum.order('datetime DESC').first
  end

  namespace :historical do

    desc 'returns historical temperature for last 24 hours'
    get "/" do
     WeatherDatum.order('datetime DESC').take(24)
    end

    desc 'returns average temperature for last 24 hours'
    get "/avg" do
      get_weather_for_last_24_hours.average(:temperature)
    end

    desc 'returns maximum temperature for last 24 hours'
    get "/max" do
      get_weather_for_last_24_hours.order('temperature DESC').first
    end

    desc 'returns minimum temperature for last 24 hours'
    get "/min" do
      get_weather_for_last_24_hours.order('temperature ASC').first
    end

    params do
      requires :time, type: Integer
    end

    desc 'returns temperature by time'
    get "/by_time" do
      return error!('Input is empty', 404) if params[:time].blank?

      weather_data = WeatherDatum.where(datetime: params[:time])
      return error!('Not Found', 404) if weather_data.empty?

      weather_data
    end
  end

  get :health do
    status 200
  end
end
