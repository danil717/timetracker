module TasksHelper
	def projects_for_select
      Project.all.collect { |c| [c.name, c.id] }
  end
end
