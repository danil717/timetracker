class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks

  def admin?
    role == 'admin'
  end

  def havent_end_time_task?

   tasks.not_finished.first

  end

#@todayTasks = Task.select('tasks.*, projects.name AS project_name').joins(:project).where('tasks.created_at >= ?', Date.today)

end
