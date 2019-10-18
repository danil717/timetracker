class ApplicationController < ActionController::Base
  def home
    #debugger
    redirect_to new_user_session_path unless current_user

    @task = Task.new
    @todayTasks = Task.select('*, projects.name AS project_name, tasks.description AS task_description, tasks.created_at AS task_time_created').joins(:project).where('tasks.created_at >= ?', Date.today)

    #@empty_task = Task.where.not(end_time: [nil, ""])



  end
end
