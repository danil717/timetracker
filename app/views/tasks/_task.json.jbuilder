json.extract! task, :id, :project_id, :user_id, :end_time, :name, :description, :created_at, :updated_at
json.url task_url(task, format: :json)
