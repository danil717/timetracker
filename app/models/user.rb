class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks
  has_one :сustomer
  accepts_nested_attributes_for :сustomer

  def admin?
    role == 'admin'
  end

  def customer?
    Customer.where('user_id = ?', id).present?
  end

  def havent_end_time_task?
    tasks.not_finished.first
  end

  def projects
    Project.projects_for_customer.where('user_id = ?', id)
  end

  scope :add_customer, ->(params) {
    Customer.update('name = ?', params[:name_customer], 'user_id = ?', id)
  }
#@todayTasks = Task.select('tasks.*, projects.name AS project_name').joins(:project).where('tasks.created_at >= ?', Date.today)

end
