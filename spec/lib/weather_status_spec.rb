require 'rails_helper'
require 'weather_status'

describe WeatherStatus do
    let(:weather_api_key) { Rails.application.credentials.weather_api_key }
  
    subject { described_class.new(weather_api_key) }
  
    describe '#weather' do
      context 'when the request is successful' do
        it 'returns parsed weather data' do
          VCR.use_cassette('successful_request') do
            expect(subject.weather).to be_an(Array)
          end
        end
      end
    end
end
