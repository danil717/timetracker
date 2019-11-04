class ApplicationController < ActionController::Base
  def home
    #debugger

    redirect_to new_user_session_path unless current_user

    task_not_finished = Task.where(id: current_user).not_finished.first

    @task = task_not_finished || Task.new

    @today_tasks = Task.today_t.proj_name.where('user_id = ?', current_user )

    #@task_not_finish = current_user.tasks.not_finished.first

    #@todayTasks = Task.select('tasks.*, projects.name AS project_name').joins(:project).where('tasks.created_at >= ?', Date.today)
  end

  # def not_found
  #   raise ActionController::RoutingError.new('Not Found')
  #   ActionController::RoutingError
  # rescue
  #   render_404
  # end
  #
  # def render_404
  #   render file: "#{Rails.root}/public/404", status: :not_found
  # end
  #
  # def page_not_found
  #   respond_to do |format|
  #     format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
  #     format.all  { render nothing: true, status: 404 }
  #   end
  # end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end
