class ApplicationController < ActionController::Base
  def home
    #debugger
    
    @task = Task.new
  end

end
