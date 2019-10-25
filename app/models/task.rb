class Task < ApplicationRecord

	belongs_to :project
	belongs_to :user

	validates_length_of :description, minimum: 10, allow_blank: true

	scope :not_finished, -> {
  	where(:end_time => nil)
	}

	def full_t
     full_time = end_time.to_i - created_at.to_i

     seconds = full_time % 60
     minutes = (full_time / 60) % 60
     hours = full_time / (60 * 60)

     format("%02d:%02d:%02d", hours, minutes, seconds)
	end

end
