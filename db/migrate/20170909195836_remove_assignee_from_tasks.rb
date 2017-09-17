class RemoveAssigneeFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :assignee, :string
  end
end
