json.extract! task, :id, :xml_id, :category, :content, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
