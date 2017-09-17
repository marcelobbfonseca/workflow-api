class AddLaneReferencesToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :lane, foreign_key: true
  end
end
