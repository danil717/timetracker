module TasksHelper
  def projects_for_select
      Project.all.collect { |c| [c.name, c.id] }
  end
  def projects_for_select_tasks    
      Task.proj_name_for_current_user.where('users.id = ?', current_user).collect { |c| [c.project_name, c.project_id]}
  end

  def format_time_task(time_date)
    time_date.strftime("%H:%M:%S")
  end

end
