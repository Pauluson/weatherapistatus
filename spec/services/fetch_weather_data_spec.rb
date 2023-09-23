require 'rails_helper'

describe FetchWeatherData do
  describe '.call' do
    let(:weather_data) { [{ 'EpochTime' => 1, 'Temperature' => { 'Metric' => { 'Value' => 20 } } }] }

    before do
      allow_any_instance_of(WeatherStatus).to receive(:weather).and_return(weather_data)
    end

    it 'creates records' do
      expect { described_class.call }.to change(WeatherDatum, :count).by(1)
    end

    it 'stores the correct datetime and temperature' do
      described_class.call
      weather_datum = WeatherDatum.last
      expect(weather_datum.datetime).to eq(1)
      expect(weather_datum.temperature).to eq(20)
    end
  end
end
