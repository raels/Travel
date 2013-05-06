# right justified and padded within N characters

def rj_money amount, width=15
	number_to_currency(amount).rjust(width)
end

def rj_money_nbsp amount, width=15
	number_to_currency(amount).rjust(width).gsub(/ /,'&nbsp;')
end

def rj_money_pre amount, width=15
	'<pre>'+rj_money(amount, width)+'</pre>'
end

def rj_money_safe amount, width=15
	rj_money(amount, width).html_safe
end

def rj_money_pre_safe amount, width=15
	rj_money_pre(amount,width).html_safe
end

ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

if false
  section "Quarterly Expense Totals", :priority => 9 do
	pre ("Q1:  " + rj_money(TripEstimate.q1total))
	pre ("Q2:  " + rj_money(TripEstimate.q2total))
	pre ("Q3:  " + rj_money(TripEstimate.q3total))
	pre ("Q4:  " + rj_money(TripEstimate.q4total))
	pre ("YTD: " + rj_money(TripEstimate.ytd_total))
	
  end

	
	#   [:q1, :q2, :q3, :q4, :year_to_date].each do |quarter|
	# 	section "Period:  #{quarter.to_s.upcase}" do
	# 		div :style => 'layout:block;' do
	# 			br
	# 			para ""
	# 			table_for TripEstimate.send(quarter).select('traveller, sum(estimated_total_cost_usd) as total').group('traveller') do 
	# 				column :traveller
	# 				column :quarter_total do |t|
	# 					number_to_currency t.total
	# 				end
	# 			end
	# 		end
	# 	end
	# end

  section "Quarterly Details", :priority => 1 do

  [:q1, :q2, :q3, :q4, :year_to_date].each do |quarter|
			div :style => 'layout:inline-block;' do
				h3 "Period: #{quarter.to_s.upcase}"
				table_for TripEstimate.send(quarter).select('traveller, sum(estimated_total_cost_usd) as total').group('traveller') do 
					column :traveller
					column :quarter_total do |t|
						number_to_currency t.total
					end
				end
			end
			para ''
			para ''
		end
	end
end
  section "Recent changes", :priority => 2 do
	table_for TripEstimate.recent(5) do
		column :traveller
		column :entered_at do |trip|
			link_to( trip.created_at.localtime.to_s(:db), admin_trip_estimate_path(trip) )
		end
		column :estimated_total_cost_usd do |trip|
			#para link_to( ('<pre>'+number_to_currency(trip.estimated_total_cost_usd).rjust(15)+'</pre>').html_safe, admin_trip_estimate_path(trip) )
			#rj_money_pre_safe(trip.estimated_total_cost_usd)
			rj_money_nbsp(trip.estimated_total_cost_usd).html_safe
		end
		# column :estimated_total_cost_usd do |trip|
		# 	column :max_width => '100px' do
		# 		link_to( number_to_currency(trip.estimated_total_cost_usd).rjust(15), admin_trip_estimate_path(trip) )
		# 	end
		# end
		
	end
  end

	#   section "Sample Graph", :priority => 2 do
	# div :style => "display:block;" do
	#       br
	#       text_node %{<iframe src="/charts/samples" width="800" height="500" scrolling="no" frameborder="no"></iframe>}.html_safe
	#     end
	#   end

  section "Expenses", :priority => 3 do
	div :id => 'qebt', :style=>"min-width: 400px; width:500px; height: 400px; margin: 0 auto" do
	end 
	
	div :style => 'display:inline-block;float:right;' do
	  script :type => 'text/javascript' do
		 HighLevelCharting.stacked_bar_chart(
			'qebt',
			"Expenses by Traveler for #{Time.now.year}" , 
			TripEstimate.quarterly_report(:q1,:q2,:q3,:q4,:year_to_date),
			:categories => [:q1,:q2,:q3,:q4,:year_to_date] 
			).html_safe.js_code
		end
	end
  end


end
