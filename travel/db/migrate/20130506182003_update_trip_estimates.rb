class UpdateTripEstimates < ActiveRecord::Migration
  def up
	# If this were ever to be deployed, go and get all the unique cost center strings and then remap them.  Since this is not yet approved for deployment
	# and there is no real data, don't worry about it for now. [TODO -- check to see if we need to do the update in the migration now!]
	add_column :trip_estimates, :cost_center_id, :integer
	remove_column :trip_estimates, :cost_center
	#default_cost_center = CostCenter.find_or_create_by_title('unassigned')
  end

  def down
	remove_column :trip_estimates, :cost_center_id
	add_column :trip_estimates, :cost_center, :string
  end
end
