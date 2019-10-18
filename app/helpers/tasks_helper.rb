module TasksHelper
  def projects_for_select
      Project.all.collect { |c| [c.name, c.id] }
  end

   def full_t(end_t, start_t)
      @full_time = end_t - start_t
      #Time.at(@full_time).utc.strftime("%H:%M:%S")
      seconds = @full_time % 60
      minutes = (@full_time / 60) % 60
      hours = @full_time / (60 * 60)
 
      format("%02d:%02d:%02d", hours, minutes, seconds) 
   end

   

end
