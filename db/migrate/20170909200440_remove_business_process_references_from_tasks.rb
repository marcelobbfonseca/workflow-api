class RemoveBusinessProcessReferencesFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_reference :tasks, :business_process, foreign_key: true
  end
end
