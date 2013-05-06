require 'pp'
class TripEstimate < ActiveRecord::Base
  attr_accessible :air_cost, :booked_at, :cost_center, :departure_airport, :departure_city, :destination_airport, :destination_city, :ended_at, :estimated_car_daily_expense_with_tax, :estimated_hotel_nightly_expense_with_tax, :estimated_total_cost_usd, :hotel, :hotel_nights, :manager, :purpose, :rental_car_days, :started_at, :traveller, :cost_center_id

	after_validation :update_estimated_cost
	
	belongs_to :cost_center
	
	scope :q1, where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,1,1), Date.new(Time.now.year,4,1))
	scope :q2, where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,4,1), Date.new(Time.now.year,7,1))
	scope :q3, where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,7,1), Date.new(Time.now.year,10,1))
	scope :q4, where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,10,1), Date.new(Time.now.year+1,1,1))
	scope :year_to_date, where( 'ended_at >= ?', Date.new(Time.now.year,1,1))
	
	scope :recent, lambda { |items| TripEstimate.order('created_at DESC').limit(items) }
		
	# def self.q1total
	# 	year_to_date.where( 'ended_at < ?', Date.new(Time.now.year,4,1)).sum(:estimated_total_cost_usd)
	# end
	# 
	# def self.q2total
	# 	year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,4,1), Date.new(Time.now.year,7,1)).sum(:estimated_total_cost_usd)
	# end
	# 
	# def self.q3total
	# 	year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,7,1), Date.new(Time.now.year,10,1)).sum(:estimated_total_cost_usd)
	# end
	# 
	# def self.q4total
	# 	year_to_date.where( 'ended_at >= ? and ended_at < ?', Date.new(Time.now.year,10,1), Date.new(Time.now.year+1,1,1)).sum(:estimated_total_cost_usd)
	# end
	

	def self.q1total
		self.q1.sum(:estimated_total_cost_usd)
	end

	def self.q2total
		self.q2.sum(:estimated_total_cost_usd)
	end

	def self.q3total
		self.q3.sum(:estimated_total_cost_usd)
	end

	def self.q4total
		self.q4.sum(:estimated_total_cost_usd)
	end

	def self.ytd_total
		self.year_to_date.sum(:estimated_total_cost_usd)
	end
	
	def self.travellers
		year_to_date.select(:travellers).uniq
	end
		
	def self.in_sum_by(skopes, group_by_field, field_to_sum)
		the_hash = Hash.new { |h,k| h[k] = Array.new }
		skopes.each_with_index do |s,i| 
			hsh = self.send(s).group(group_by_field).sum(field_to_sum)
			hsh.each { |k,v| the_hash[k][i] = v.try(:to_f) || 0.0 }
		end
		final_result = the_hash.collect do |person,arr| 
			{ 
				:name => person, 
				:data => arr,
				:url => "/admin/trip_estimates?q%5Btraveller_contains%5D=#{person.downcase.gsub(/\s+/,'+')}"
         	}
		end
		pp ["the returned hash",final_result]
		final_result
	end
	
	def self.quarterly_report(*skopes)
		self.in_sum_by(skopes, :traveller, :estimated_total_cost_usd)
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
