class RenameCurrentTaskOnBusinessProcess < ActiveRecord::Migration[5.1]
  def change
    rename_column :business_processes, :current_task, :current_task_id
  end
end
