require 'pp'
ActiveAdmin.register_page "User Reports" do
  controller do
	
	def make_a_chart
		@h1 = LazyHighCharts::HighChart.new('graph') do |f| 
			f.options[:chart][:defaultSeriesType] = "area" 
			f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9]) 
			f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] ) 
			end
	end
	
  end

  content do
	menu :label => "My Menu Item Label", :parent => "Dashboard"
  	
 	div :style => 'display:inline-block;float:left;' do
	    [:q1, :q2, :q3, :q4, :year_to_date].each do |period|
			div "Period:  #{period.to_s.upcase}", :class => 'mydiv'  do
				table_for TripEstimate.send(period).select('traveller, sum(estimated_total_cost_usd) as total').group('traveller') do 
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
	  
 	div :id => 'qebt', :style=>"min-width: 400px; width:500px; height: 400px; margin: 0 auto" do
	end 
	
	div :style => 'display:inline-block;float:right;' do
	  script :type => 'text/javascript' do
		 HighLevelCharting.stacked_bar_chart(
			'qebt',
			"Expenses by Traveler for #{Time.now.year}", 
			TripEstimate.quarterly_report(:q1,:q2,:q3,:q4,:year_to_date),
			:categories => [:q1,:q2,:q3,:q4,:year_to_date] 
			).html_safe.js_code
		end
	end
	
	
  end
	
end


# LazyHighCharts::HighChart.new('graph') do |f|
# 	f.options[:chart][:defaultSeriesType] = 'bar'
# 	f.options[:title][:text] = 'Quarterly Expenses'
# 	f.options[:xAxis][:categories] = ['1Q2012','2Q2012','3Q2012','4Q2012','YTD2012']
# 	f.options[:yAxis][:text] = 'Total Expense'
# 	f.options[:yAxis][:stackLabels] = {}
# 	f.options[:yAxis][:stackLabels][:enabled]='true';
# 	f.options[:yAxis][:stackLabels][:style] = {}
# 	f.options[:yAxis][:stackLabels][:style][:fontWeight]='bold';
# 	f.options[:yAxis][:stackLabels][:style][:fontWeight]="(Highcharts.theme && Highcharts.theme textColor) || 'gray' ";
# 	f.options[:tooltip][:formatter]="function() { return '<b>'+ this.x +'</b><br/>'+this.series.name +': '+ this.y +'<br/>'+'Total: '+ this.point.stackTotal;}"
# 	f.options[:plotOptions] = {}
# 	f.options[:plotOptions][:series] = {}
# 	f.options[:plotOptions][:series][:stacking] = 'normal'
# 	f.options[:plotOptions][:series][:dataLabels] = {}	
# 	f.options[:plotOptions][:series][:dataLabels][:enabled] = 'true'
# 	f.options[:plotOptions][:series][:dataLabels][:color] = "(Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'"
# 	[:q1, :q2, :q3, :q4, :year_to_date].each do |skope|
# 		period_total = TripEstimate.send(skope).select('sum(estimated_total_cost_usd) as total')
# 		f.series(:name => skope.to_s.upcase, :data => period_total)
# 	end
# end
# 

	# $(function () {
#     var chart;
# 
#     $(document).ready(function() {
#         chart = new Highcharts.Chart({
#             chart: {
#                 renderTo: 'container',
#                 type: 'bar'
#             },
#             title: {
#                 text: 'Stacked bar chart'
#             },
#             xAxis: {
#                 categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
#             },
#             yAxis: {
#                 min: 0,
#                 title: {
#                     text: 'Total fruit consumption'
#                 },
#                 stackLabels: {
#                 enabled: true,
#                 style: {
#                     fontWeight: 'bold',
#                     color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
#                 }
#             }
# 
#             },
# 
#             legend: {
# 
#                align: 'right',
#             x: -100,
#             verticalAlign: 'top',
#             y: 20,
#             floating: true,
#             backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
#             borderColor: '#CCC',
#             borderWidth: 1,
#             shadow: false
# 
#             },
# 
#             tooltip: {
# 
#               formatter: function() {
#                 return '<b>'+ this.x +'</b><br/>'+
#                     this.series.name +': '+ this.y +'<br/>'+
#                     'Total: '+ this.point.stackTotal;
#             }
# 
#             },
# 
#             plotOptions: {
# 
#                 series: {
# 
#                     stacking: 'normal',
#                     dataLabels: {
#                     enabled: true,
#                     color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
#                 }
#                     
# 
#                 }
# 
#             },
# 
#                 series: [{
# 
#                 name: 'John',
# 
#                 data: [5, 3, 4, 7, 2]
# 
#             }, {
# 
#                 name: 'Jane',
# 
#                 data: [2, 2, 3, 2, 1]
# 
#             }, {
# 
#                 name: 'Joe',
# 
#                 data: [3, 4, 4, 2, 5]
# 
#             }]
# 
#         });
# 
#     });
# 
#     
# });​
