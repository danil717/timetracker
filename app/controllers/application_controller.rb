class ApplicationController < ActionController::Base
  def home
    #debugger
    redirect_to new_user_session_path unless current_user

    @task = Task.new
    @today_tasks = Task.today_t.proj_name.where('user_id = ?', current_user )

    #@task_not_finish = current_user.tasks.not_finished.first

    #@todayTasks = Task.select('tasks.*, projects.name AS project_name').joins(:project).where('tasks.created_at >= ?', Date.today)
  end
end
