class CreateWeatherData < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_data do |t|
      t.float :temperature
      t.integer :datetime

      t.timestamps
    end
  end
end
