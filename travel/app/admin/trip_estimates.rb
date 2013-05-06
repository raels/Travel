ActiveAdmin.register TripEstimate do
 	
	scope :q1 
	scope :q2 
	scope :q3 
	scope :q4 
	scope :year_to_date 
	
	sidebar :help do
	    "Need help? Email us at help@example.com"
	end
	
	csv do
		column :cost_center
		column :traveller
		column :manager
		column :destination_city
		column :destination_airport
		column :departure_city
		column :departure_airport
		column(:booked_at) { |trip| trip.booked_at.strftime('%m/%d/%Y') }
		column(:started_at) { |trip| trip.started_at.strftime('%m/%d/%Y') }
		column(:ended_at) { |trip| trip.ended_at.strftime('%m/%d/%Y') }
		column :hotel
		column(:air_cost) { |trip| number_to_currency trip.air_cost }
		column(:estimated_hotel_nightly_expense_with_tax) { |trip| number_to_currency trip.estimated_hotel_nightly_expense_with_tax }
		column :hotel_nights
		column(:estimated_car_daily_expense_with_tax) { |trip| number_to_currency trip.estimated_car_daily_expense_with_tax }
		column :rental_car_days
		column(:estimated_total_cost_usd) { |trip| number_to_currency trip.estimated_total_cost_usd }
		column :purpose
	end
	
	#filter :date_booked_at, :as => :datepicker
	
	index do
		column :cost_center
		column :traveller
		column :manager
		column :destination_city
		column :destination_airport
		column :departure_city
		column :departure_airport
		column :booked_at, :as => :datepicker
		column :started_at, :as => :datepicker
		column :ended_at, :as => :datepicker
		column :hotel
		column("Air Cost", :sortable => :air_cost) { |trip| number_to_currency trip.air_cost }
		column(:estimated_hotel_nightly_expense_with_tax) { |trip| number_to_currency trip.estimated_hotel_nightly_expense_with_tax }
		column :hotel_nights
		column(:estimated_car_daily_expense_with_tax) { |trip| number_to_currency trip.estimated_car_daily_expense_with_tax }
		column :rental_car_days
		column(:estimated_total_cost_usd) { |trip| number_to_currency trip.estimated_total_cost_usd }
		column :purpose
		
		
		default_actions
	end	
	
	form do |f|
	  f.inputs do
		f.input :cost_center
		f.input :traveller
		f.input :manager
		f.input :destination_city
		f.input :destination_airport
		f.input :departure_city
		f.input :departure_airport
		f.input :booked_at, :as => :datepicker
		f.input :started_at, :as => :datepicker
		f.input :ended_at, :as => :datepicker
		f.input :hotel
		f.input :air_cost 
		f.input :estimated_hotel_nightly_expense_with_tax
		f.input :hotel_nights
		f.input :estimated_car_daily_expense_with_tax
		f.input :rental_car_days
		f.input :estimated_total_cost_usd
		f.input :purpose
	  end
	  f.buttons
			
	end
	
end
