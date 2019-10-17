class ApplicationController < ActionController::Base
  def home
    #debugger
    if current_user

    else
      redirect_to new_user_session_path
    end

    @task = Task.new
    @todayTasks = Task.select('*, projects.name AS project_name, tasks.description AS task_description').joins(:project).where('tasks.created_at >= ?', Date.today)

    #@empty_task = Task.where.not(end_time: [nil, ""])
  end
end
