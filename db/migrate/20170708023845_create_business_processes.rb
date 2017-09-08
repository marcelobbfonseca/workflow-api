class CreateBusinessProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :business_processes do |t|
      t.string :name
      t.integer :current_task

      t.timestamps
    end
  end
end
