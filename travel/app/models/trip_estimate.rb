class TripEstimate < ActiveRecord::Base
  attr_accessible :air_cost, :booked_at, :cost_center, :departure_airport, :departure_city, :destination_airport, :destination_city, :ended_at, :estimated_car_daily_expense_with_tax, :estimated_hotel_nightly_expense_with_tax, :estimated_total_cost_usd, :hotel, :hotel_nights, :manager, :purpose, :rental_car_days, :started_at, :traveller

	after_validation :update_estimated_cost
	
	# scope :q1, where( 'month(ended_at) between 1 and 3')
	# scope :q2, where( 'month(ended_at) between 1 and 3')
	# scope :q3, where( 'month(ended_at) between 1 and 3')
	# scope :q4, where( 'month(ended_at) between 1 and 3')
	# scope :year_to_date, where( 'year(ended_at) = year(today())')

	#scope :q1, where( " ended_at >= date('2012-01-01') and ended_at < date('2010-04-01) ")
	scope :q1, where( " strftime('%m', ended_at) between '01' and '03' ")
	scope :q2, where( " strftime('%m', ended_at) between '04' and '06' ")
	scope :q3, where( " strftime('%m', ended_at) between '07' and '09' ")
	scope :q4, where( " strftime('%m', ended_at) between '10' and '12' ")
	scope :year_to_date, where( "ended_at >= '#{Time.now.year}-01-01'")
	
	scope :recent, lambda { |items| TripEstimate.order('created_at DESC').limit(items) }
	
	def self.q1total
		year_to_date.where( 'ended_at < ?', Date.new(Time.now.year,4,1)).sum(:estimated_total_cost_usd)
	end

	def self.q2total
		year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,4,1), Date.new(Time.now.year,7,1)).sum(:estimated_total_cost_usd)
	end

	def self.q3total
		year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,7,1), Date.new(Time.now.year,10,1)).sum(:estimated_total_cost_usd)
	end

	def self.q4total
		year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,10,1), Date.new(Time.now.year+1,1,1)).sum(:estimated_total_cost_usd)
	end
	
private

	def update_estimated_cost
		self.estimated_total_cost_usd = total_hotel_expense + total_car_expense + total_air_expense rescue 0.0
	end
	
	def total_hotel_expense
		self.hotel_nights * self.estimated_hotel_nightly_expense_with_tax rescue 0.0
	end
	
	def total_car_expense
		self.rental_car_days * self.estimated_car_daily_expense_with_tax rescue 0.0
	end
	
	def total_air_expense
		self.air_cost rescue 0.0
	end
		
end
