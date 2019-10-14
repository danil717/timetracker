module ApplicationHelper
	def users_for_select
    User.all.collect { |u| [u.email, u.id] }
  end
end
