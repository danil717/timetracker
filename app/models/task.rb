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

  #def self.search_by(search_term)
   # proj_name.where("LOWER(projects.name) LIKE :search_term", search_term: "#{search_term.downcase}%")    
  #end 
  scope :search_by, ->(params) {
    search_by_project(params[:project_id]).
    search_by_date(params[:search_date_1], params[:search_date_2]).
    search_by_length_desc(params[:long_short]).
    search_by_length_asc(params[:short_long])

  }

  scope :search_by_project, -> (project_id){
    where(project_id: project_id) if project_id.present?
  }

  scope :search_by_date, -> (date_1, date_2) {
    where(created_at: date_1.to_date.beginning_of_day..date_2.to_date.end_of_day) if date_1.present? || date_2.present?
  }

  scope :search_by_length_desc, ->(time_length) {
   select('*, (tasks.end_time - tasks.created_at) as diff_time').order('diff_time DESC') if time_length.present? 
  }

  scope :search_by_length_asc, ->(time_length2) {
   select('*, (tasks.end_time - tasks.created_at) as diff_time').order('diff_time ASC') if time_length2.present? 
  }




	def full_t
     full_time = end_time.to_i - created_at.to_i

     seconds = full_time % 60
     minutes = (full_time / 60) % 60
     hours = full_time / (60 * 60)

     format("%02d:%02d:%02d", hours, minutes, seconds)
	end


end
