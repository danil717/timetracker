class Task < ApplicationRecord

	self.per_page = 10

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

	def full_time
     full_time = end_time.to_i - created_at.to_i

     seconds = full_time % 60
     minutes = (full_time / 60) % 60
     hours = full_time / (60 * 60)

     format("%02d:%02d:%02d", hours, minutes, seconds)
	end

	def created_at_strf
		created_at.strftime("%H:%M:%S")
	end

	def end_time_strf
		end_time.strftime("%H:%M:%S")
	end
end
