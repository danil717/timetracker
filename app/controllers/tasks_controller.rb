class TasksController < ApplicationController
  before_action :check_user
  before_action :end_task, only: [:create]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :completion, :check_user_in_this_task?]
  #before_action :check_user_in_this_task, :only [:completion]
  skip_before_action :verify_authenticity_token
  require 'will_paginate/array'

  # GET /tasks
  # GET /tasks.json
  def index
   @tasks = []
     # @tasks = current_user.tasks
    if current_user
      if current_user.admin?
        @tasks_index = Task.proj_name.search_by(params)
      else
        @tasks_index = Task.where(user_id: current_user).proj_name.search_by(params)
      end

      @date_1 = params[:search_date_1]
      @date_2 = params[:search_date_2]

      if params[:long_short].present? 
        @is_checked = true
         @is_checked2 = false     
      else 
      @is_checked = false
      end

       if params[:short_long].present?
        @is_checked2 = true
        @is_checked = false
      else
        @is_checked2 = false
      end

      @tasks_index.each do |t|
        @tasks.push(t)
      end
      @tasks = @tasks.paginate(page: params[:page], per_page: 10)
    else
      redirect_to new_user_session_path
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.newdef task_params

      if current_user.admin?
        params.require(:task).permit(:project_id, :user_id, :description)
      else
        params.require(:task).permit(:project_id, :description)
      end
    end
  end

  # GET /tasks/1/edit
  def edit
  end


  # POST /tasks
  # POST /tasks.json
  def create
    #@end_task = Task.where('user_id = ?', current_user).order('created_at').last(1)
    #if @end_task[0].end_time
      if current_user.admin? && params[:user_id].present?
        @task = Task.new(task_params)
      else
        @task = current_user.tasks.new(task_params)
      end
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.js { render :created }
        else
          format.html { render :new }
          format.js { render :created_error }
        end
      end
    #else
      #respond_to do |format|
        #format.js { render :created_error }
      #end
    #end
  end

  def completion
    # Task.find(params[:id]).update(end_time: DateTime.now)
    respond_to do |format|
      if check_user_in_this_task? && !@task.end_time && @task.update(end_time: DateTime.now)
        format.json { render json: @task.to_json(methods: [:full_time, :end_time_strf, :created_at_strf]) }
      else
        format.js { render :created_error }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.select('tasks.*, projects.name AS project_name').joins(:project).find(params[:id])
    end

    def end_task
      render :created_error unless !current_user.havent_end_time_task?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      if current_user.admin?
        params.require(:task).permit(:project_id, :user_id, :description)
      else
        params.require(:task).permit(:project_id, :description)
      end
    end

    def task_end_time
      params.require(:task).permit(:end_time)
    end

    def check_user
      redirect_to new_user_session_path unless current_user
    end

    def check_user_in_this_task?
      @task.user_id == current_user.id
    end
end
