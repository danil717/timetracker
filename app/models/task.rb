class Task < ApplicationRecord

	belongs_to :project
	belongs_to :user

validates_length_of :description, minimum: 10, allow_blank: true
	
scope :not_finished, -> {
  where(:end_time => nil)
} 

 scope :today_t, -> {
 	where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
 }

 scope :proj_name, -> {
 	select('tasks.*, projects.name AS project_name').joins(:project)
 }

end
