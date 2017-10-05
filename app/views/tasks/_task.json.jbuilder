json.extract! task, :id, :xml_id, :category, :content, :status, :created_at, :updated_at

if task.assignee.present?
    json.assignee task.assignee, partial: 'users/user', as: :user
end

json.url task_url(task, format: :json)
