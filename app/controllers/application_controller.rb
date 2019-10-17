class ApplicationController < ActionController::Base
  def home
    #debugger
    
    @task = Task.new

    if current_user
      @todayTasks = Task.select('*, projects.name AS project_name, tasks.description AS task_description').joins(:project).where('user_id = ?', current_user).where('tasks.created_at >= ?', Date.today)
    end

    
    #@empty_task = Task.where.not(end_time: [nil, ""])  
    
  
  end
end
