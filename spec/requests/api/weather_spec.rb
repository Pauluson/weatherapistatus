require 'swagger_helper'

describe 'Weather API' do
    path '/weather/current' do
      get 'Retrieves the current temperature' do
        tags 'Weather'
        produces 'application/json'
  
        response '200', 'temperature found' do
          schema type: :object,
            properties: {
              temperature: { type: :integer }
            },
            required: ['temperature']
          run_test!
        end
  
        response '404', 'temperature not found' do
          schema type: :object,
            properties: {
              error: { type: :string }
            },
            required: ['error']
          run_test!
        end
      end
    end
  
    path '/weather/historical' do
      get 'Retrieves historical temperature for the last 24 hours' do
        tags 'Weather'
        produces 'application/json'
  
        response '200', 'historical temperature found' do
          schema type: :array,
            items: {
              type: :object,
              properties: {
                datetime: { type: :integer },
                temperature: { type: :integer }
              },
              required: ['datetime', 'temperature']
            }
          run_test!
        end
      end
    end
  
    path '/weather/historical/avg' do
      get 'Retrieves the average temperature for the last 24 hours' do
        tags 'Weather'
        produces 'application/json'
  
        response '200', 'average temperature found' do
          schema type: :object,
            properties: {
              avg: { type: :number, format: :float }
            },
            required: ['avg']
          run_test!
        end
      end
    end
  
    path '/weather/historical/max' do
      get 'Retrieves the maximum temperature for the last 24 hours' do
        tags 'Weather'
        produces 'application/json'
  
        response '200', 'maximum temperature found' do
          schema type: :object,
            properties: {
              temperature: { type: :integer }
            },
            required: ['temperature']
          run_test!
        end
      end
    end
  
    path '/weather/historical/min' do
      get 'Retrieves the minimum temperature for the last 24 hours' do
        tags 'Weather'
        produces 'application/json'
  
        response '200', 'minimum temperature found' do
          schema type: :object,
            properties: {
              temperature: { type: :integer }
            },
            required: ['temperature']
          run_test!
        end
      end
    end
  
    path '/weather/historical/by_time' do
      get 'Retrieves temperature for a specific time' do
        tags 'Weather'
        produces 'application/json'
        parameter name: :time, in: :query, type: :integer, required: true,
          description: 'Timestamp for the requested time'
  
        response '200', 'temperature found' do
          schema type: :object,
            properties: {
              datetime: { type: :integer },
              temperature: { type: :integer }
            },
            required: ['datetime', 'temperature']
          run_test!
        end
  
        response '404', 'temperature not found' do
          schema type: :object,
            properties: {
              error: { type: :string }
            },
            required: ['error']
          run_test!
        end
      end
    end

    path '/weather/health' do
        get 'Retrieves the health status of the weather service' do
          tags 'Weather'
          produces 'application/json'
      
          response '200', 'health status found' do
            schema type: :object,
              properties: {
                status: { type: :integer }
              },
              required: ['status']
            run_test!
          end
        end
      end
  end
