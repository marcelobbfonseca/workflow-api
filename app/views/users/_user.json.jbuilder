json.extract! user, :id, :name, :role
unless user.assign_to.empty?
  json.assign_to user.assign_to do |task|
    json.id task.id
    json.content task.content
    json.status task.status
    json.category task.category
    json.business_process do
      json.id task.business_process.id
      json.name task.business_process.name
    end

  end
end
json.url user_url(user, format: :json)
