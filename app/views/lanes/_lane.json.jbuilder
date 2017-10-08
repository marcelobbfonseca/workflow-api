json.extract! lane, :id, :name

if lane.tasks.present?
  json.tasks lane.tasks do |task|
    json.id task.id
    json.content task.content
    json.assignee task.assignee
    json.category task.category
  end

end


json.url lane_url(lane, format: :json)
