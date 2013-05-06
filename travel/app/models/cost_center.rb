class CostCenter < ActiveRecord::Base
  attr_accessible :title
	
  has_many :trip_estimates

end
