FactoryBot.define do
  factory :weather_datum do
    datetime { Time.now }
    temperature { 1695452280 }
  end
end
