class CreateTripEstimates < ActiveRecord::Migration
  def change
    create_table :trip_estimates do |t|
      t.string :cost_center
      t.string :traveller
      t.string :manager
      t.string :destination_city
      t.string :destination_airport
      t.string :departure_city
      t.string :departure_airport
      t.datetime :booked_at
      t.datetime :started_at
      t.datetime :ended_at
      t.string :hotel
      t.decimal :air_cost, :precision => 7, :scale => 2
      t.decimal :estimated_hotel_nightly_expense_with_tax, :precision => 7, :scale => 2
      t.integer :hotel_nights
      t.decimal :estimated_car_daily_expense_with_tax, :precision => 7, :scale => 2
      t.integer :rental_car_days
      t.decimal :estimated_total_cost_usd, :precision => 7, :scale => 2
      t.string :purpose

      t.timestamps
    end
  end
end
