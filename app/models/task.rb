class Task < ApplicationRecord

	belongs_to :project
	belongs_to :user

validates_length_of :description, minimum: 10, allow_blank: true
	
scope :not_finished, -> {
  where(:end_time => nil)
}
	

end
