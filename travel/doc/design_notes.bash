
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

TimeEstimate.joins([:periods]).where("periods.name like '_Q2011' and time_estimates.ending_at >= periods.starting_at and time_estimates.ending_at < periods.ending_at
	
TT;MS


	