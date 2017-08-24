json.extract! task, :id, :diagram_id, :xml_id, :category, :content, :status, :assignee, :created_at, :updated_at
json.url task_url(task, format: :json)
