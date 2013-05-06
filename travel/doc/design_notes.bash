
rails=rails
scaffold=scaffold
money='decimal{7,2}'

$rails generate $scaffold TripEstimate \
	cost_center:string \
	traveller:string \
	manager:string \
	destination_city:string \
	destination_airport:string \
	departure_city:string \
	departure_airport:string \
	booked_at:datetime \
	started_at:datetime \
	ended_at:datetime \
	hotel:string \
	air_cost:$money \
	estimated_hotel_nightly_expense_with_tax:$money \
	hotel_nights:integer \
	estimated_car_daily_expense_with_tax:$money \
	rental_car_days:integer \
	estimated_total_cost_usd:$money \
	purpose:string

cat > /dev/null <<EOF	
# quarters are an artifact of given dates, so handle that separately
# this should be factored as follows

Traveller > (Employee | Guest)
	Employees have managers, guests have hosting employee.  I think the importance here is who is approving the expense.

A more useful id is email address, since we can tell much about the person from it.  We can also use it to look up the manager, etc., from nvinfo


$rails generate $scaffold cost_center \
	title:string \
	code:string
# has_one :manager, :class_name => "Person", foreign_key => :person_id 

----------  these are all wrong... need to generate them then add the fields... how lame is that?

$rails generate $scaffold Person \
	name:string \
	title:string \
	email:string
	
$rails generate $scaffold Employee \
	person:references \
	is_manager:boolean

$rails generate $scaffold NVidiaGroup \
	title:string \
	division:string \
	manager:references

$rails generate $scaffold Location \
	title:string \
	street1:string \
	street2:string \
	city:string \
	state_or_province:string \
	postal_code:string \
	airport:references
	
$rails generate $scaffold Airport \
	title:string \
	code:string \
	description:string

$rails generate $scaffold Expense \
	title:string \
	vendor:references \
	expense_category:references \
	'cost_per_day:decimal{7,2}' \
	'cost_per_night:decimal{7,2}'

$rails generate $scaffold Vendor \
	title:string \
	address:references

$rails generate $scaffold Trip \
	has_many:legs
EOF


Making reporting periods easier... make a periods table!  Starting_at and ending_at are the half-open interval [starting_at, ending_at)

Period
	category:string
	name:string
	recurring_name:string
	starting_at:datetime
	ending_at:datetime
	
Example data

["Quarter", "1Q2011", 'Q1', '2011-01-01 00:00:00', '2011-04-01 00:00:00']
["Quarter", "2Q2011", 'Q2', '2011-03-01 00:00:00', '2011-07-01 00:00:00']
["Quarter", "3Q2011", 'Q3', '2011-06-01 00:00:00', '2011-10-01 00:00:00']
["Quarter", "4Q2011", 'Q4', '2011-09-01 00:00:00', '2012-01-01 00:00:00']

["Quarter", "1Q2012", 'Q1', '2012-01-01 00:00:00', '2012-04-01 00:00:00']
["Quarter", "2Q2012", 'Q2', '2012-03-01 00:00:00', '2012-07-01 00:00:00']
["Quarter", "3Q2012", 'Q3', '2012-06-01 00:00:00', '2012-10-01 00:00:00']
["Quarter", "4Q2012", 'Q4', '2012-09-01 00:00:00', '2013-01-01 00:00:00']

["Month", "01/2011", "01", '2011-01-01 00:00:00', '2011-02-01 00:00:00']
["Month", "02/2011", "02", '2011-02-01 00:00:00', '2011-03-01 00:00:00']
["Month", "03/2011", "03", '2011-03-01 00:00:00', '2011-04-01 00:00:00']
["Month", "04/2011", "04", '2011-04-01 00:00:00', '2011-05-01 00:00:00']
["Month", "05/2011", "05", '2011-05-01 00:00:00', '2011-06-01 00:00:00']
["Month", "06/2011", "06", '2011-06-01 00:00:00', '2011-07-01 00:00:00']
["Month", "07/2011", "07", '2011-07-01 00:00:00', '2011-08-01 00:00:00']
["Month", "08/2011", "08", '2011-08-01 00:00:00', '2011-09-01 00:00:00']
["Month", "09/2011", "09", '2011-09-01 00:00:00', '2011-10-01 00:00:00']
["Month", "10/2011", "10", '2011-10-01 00:00:00', '2011-11-01 00:00:00']
["Month", "11/2011", "11", '2011-11-01 00:00:00', '2011-12-01 00:00:00']
["Month", "12/2011", "12", '2011-12-01 00:00:00', '2012-01-01 00:00:00']

["Month Name", "January 2011", "01", '2011-01-01 00:00:00', '2011-02-01 00:00:00']
["Month Name", "February 2011", "02", '2011-02-01 00:00:00', '2011-03-01 00:00:00']
["Month Name", "March 2011", "03", '2011-03-01 00:00:00', '2011-04-01 00:00:00']
["Month Name", "April 2011", "04", '2011-04-01 00:00:00', '2011-05-01 00:00:00']
["Month Name", "May 2011", "05", '2011-05-01 00:00:00', '2011-06-01 00:00:00']
["Month Name", "June 2011", "06", '2011-06-01 00:00:00', '2011-07-01 00:00:00']
["Month Name", "July 2011", "07", '2011-07-01 00:00:00', '2011-08-01 00:00:00']
["Month Name", "August 2011", "08", '2011-08-01 00:00:00', '2011-09-01 00:00:00']
["Month Name", "September 2011", "09", '2011-09-01 00:00:00', '2011-10-01 00:00:00']
["Month Name", "October 2011", "10", '2011-10-01 00:00:00', '2011-11-01 00:00:00']
["Month Name", "Novenber 2011", "11", '2011-11-01 00:00:00', '2011-12-01 00:00:00']
["Month Name", "December 2011", "12", '2011-12-01 00:00:00', '2012-01-01 00:00:00']

profile = current_user.query_profile
ReportWriter.generate_all(profile.desired_reports)
profile.desired_reports.collect { |report| ReportWriter.generate(report) }

report is a Model, set of scopes, target_format

In short, looks just like a URL with a .report format at the end.  Can reuse all the same stuff.  Just put a URL in the profile.

report is a set of sections.
section has a title, an active_resource-compatible URL, and many 

Another way to look at this is a nested list of scopes -- for instance

	ReportModel.by_years.by_halves.by_quarters
	
	this needs work
	
[:y. 
	[:h1,
		[:q1,
			[:m1,:m2,:m3]
		], 
		[:q2.
			[:m4,:m5,:m6]
		]
	]
	[:h2,
		[:q3,
			[:m7, :m8, M9],
		],
		[:q4,
			[:m10, :m11, :m12]
		] 
	]
]

Creating reports from the user perspective...

Show me [this stuff] over the period(s) of [some set of intervals] broken down by [some set of groups] sorted by [some set of sort criteria]
select [some set of stuff] from [some set of sources] where [data are limited by the periods] group by [things to group by] having [some final criteria]

Show me
	sum of total_expense
broken down 
	by person within group per month within quarter withing year,
	by person per year,
	by group per year
over
	years 2009-now
where
		person.name like 'John%'
	and group not in ['Finance']
	
	
First, the fields referenced in the broken-down section must wind up in the show-me columns / row headers.  The keyword "within" makes the given quantity
appear nested below another, and will induce subtotals unless stated otherwise.

Next, the broken-down part has the format
	by STUFF per
Next, the spec produces several different report sections, but shares parts of the specification.  We generate three different sections, each one
associated with the "by" keyword in the broken-down section.  If the "over" section had a another time period in it, such as 

over
	2000-2010,
	2011-now
	
Then we would have the cross product of the sections in the broken-down part times the two different periods in the over part.
If we did this instead:

over
	[2000-2010,2011-now]

Then the cross product would not occur, as we would have 1 period and 3 sections.  We can do the same thing with broken-down part:

broken down 
	by [ person within group per month within quarter withing year, person per year, group per year ]

What does this mean in this case... well, here are what the sections look like independently

Period		Person1		Person2		Person3
Year
  Quarter
    Month
  Qarter
    Month







ReportWriter.generate

TripEstimate.joins([:periods]).where("periods.name like '_Q2011' and time_estimates.ending_at >= periods.starting_at and time_estimates.ending_at < periods.ending_at
	
So the idea is to be able to have someone express a list of periods in which they have interest, then have data in that period rendered in a chart.

I should be able to present a list of quarters, have the customer pick some subset, and then return the aggregates for that period.  
	