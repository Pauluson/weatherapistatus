require 'rails_helper'

describe Weather, type: :request do

  def app
    Weather
  end

  let(:datetime) { Time.now }

  before do
    create_list(:weather_datum, 24)
  end

  it 'returns the current temperature' do
      get '/weather/current'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to have_key('temperature')
  end

  it 'returns historical temperature for last 24 hours' do
    get '/weather/historical'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to be_an(Array)
    expect(JSON.parse(last_response.body).size).to eq(24)
  end

  it 'returns average temperature for last 24 hours' do
    get '/weather/historical/avg'
    expect(last_response.status).to eq(200)
  end
  
  it 'returns maximum temperature for last 24 hours' do
    get '/weather/historical/max'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to have_key('temperature')
  end

  it 'returns minimum temperature for last 24 hours' do
    get '/weather/historical/min'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to have_key('temperature')
  end

  it 'returns temperature by time' do
    timestamp = Time.now.to_i
    get "/weather/historical/by_time?time=#{timestamp}"
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).not_to be_empty
  end

  it 'returns 404 if time not found' do
    timestamp = 1234567890
    get "/weather/historical/by_time?time=#{timestamp}"
    expect(last_response.status).to eq(404)
    expect(JSON.parse(last_response.body)['error']).to eq('Not Found')
  end

  it 'returns 404 if time is blank' do
    get '/weather/historical/by_time?time='
    expect(last_response.status).to eq(404)
    expect(JSON.parse(last_response.body)['error']).to eq('Input is empty')
  end

  it 'returns health status' do
    get 'weather/health'
    expect(last_response.status).to eq(200)
  end
end
