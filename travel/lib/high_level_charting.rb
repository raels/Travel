class HighLevelCharting
	# stacked_bar_chart('myid', 'Quarterly Expenses', Time.quarterly_report, :y_axis_label => 'Dollars', :categories = %w{ Q1 Q2 Q3 Q4 YEAR_TO_DATE})

	def self.stacked_bar_chart(html_id, title, array_of_series, options = {})
		#x_axis_label = options[:x_axis_label] || 'PLEASE SET x_axis_label'
		y_axis_label = options[:y_axis_label] || 'PLEASE SET y_axis_label'
		category_labels = (options[:categories] || []).map(&:to_s).map(&:upcase)
		category_labels_as_string = category_labels.map { |x| "'#{x}'"}.join(', ')
		filename = options[:filename] || 'lib/stacked_bar_chart.erb'
		series_string = array_of_series.map(&:to_json).join(",\n")
		
		template = ERB.new(File.read(filename))
		output = template.result(binding)
		puts output
		output
	end

	
end
