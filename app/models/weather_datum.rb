class WeatherDatum < ApplicationRecord
  validates :temperature, presence: true
  validates :datetime, presence: true 
end
