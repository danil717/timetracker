module TasksHelper
  def projects_for_select
      Project.all.collect { |c| [c.name, c.id] }
  end

  def format_time_task(time_date)
    time_date.strftime("%H:%M:%S")
  end
end
