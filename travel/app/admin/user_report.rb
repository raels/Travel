ActiveAdmin.register_page "User Reports" do
  controller do
	
	def make_a_chart
		@h = LazyHighCharts::HighChart.new('graph') do |f| 
			f.options[:chart][:defaultSeriesType] = "area" 
			f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9]) 
			f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] ) 
			end
	end
	
  end

  content do
	# para 'Hello, world.'
	# para 'Hello, world.'
	#     TripEstimate.q1.select('traveller, sum(estimated_total_cost_usd) as tc_usd').group('traveller').each do |record|
	# 	para "Q1: " + record.traveller + " -- " + record.tc_usd.to_s
	# end
	#     TripEstimate.q2.select('traveller, sum(estimated_total_cost_usd) as tc_usd').group('traveller').each do |record|
	# 	para "Q2: " + record.traveller + " -- " + record.tc_usd.to_s
	# end
	#     TripEstimate.q3.select('traveller, sum(estimated_total_cost_usd) as tc_usd').group('traveller').each do |record|
	# 	para "Q3: " + record.traveller + " -- " + record.tc_usd.to_s
	# end
	#     TripEstimate.q4.select('traveller, sum(estimated_total_cost_usd) as tc_usd').group('traveller').each do |record|
	# 	para "Q4: " + record.traveller + " -- " + record.tc_usd.to_s
	# end
	menu :label => "My Menu Item Label", :parent => "Dashboard"
  

    div do
		make_a_chart
		para high_chart("my_id", @h).html_safe
		para "foo"
	end
	
    [:q1, :q2, :q3, :q4, :year_to_date].each do |quarter|
		div "Period:  #{quarter.to_s.upcase}", :class => 'mydiv'  do
			table_for TripEstimate.send(quarter).select('traveller, sum(estimated_total_cost_usd) as total').group('traveller') do 
				column :traveller
				column :total do |t|
					div :class => 'money' do
						number_to_currency t.total
					end
				end
			end
		end
	end
  end
end
