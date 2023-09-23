require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.in '10s' do
  FetchWeatherData.call
end
