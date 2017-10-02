json.extract! business_process, :id, :name, :current_task, :created_at, :updated_at

if business_process.lanes.present?
  json.lanes do
    json.array! business_process.lanes, partial: 'lanes/lane', as: :lane
  end
end

json.url business_process_url(business_process, format: :json)
