json.extract! lane, :id, :name, :created_at, :updated_at

if lane.tasks.present?
  json.tasks do
    json.array! lane.tasks, partial: 'tasks/task', as: :task
  end

end


json.url lane_url(lane, format: :json)
