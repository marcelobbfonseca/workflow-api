json.extract! task, :id, :xml_id, :category, :content, :status, :created_at, :updated_at

if task.assignee.present?
    json.assignee task.assignee, partial: 'users/user', as: :user
end

if task.next_tasks.present?
    json.next_tasks task.next_tasks do |next_task|
      json.id next_task.id
      json.content next_task.content
      json.assignee next_task.assignee
      json.category next_task.category
    end
end

json.url task_url(task, format: :json)
