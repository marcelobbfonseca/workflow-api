json.extract! business_process, :id, :name, :task_id, :created_at, :updated_at
json.url business_process_url(business_process, format: :json)
