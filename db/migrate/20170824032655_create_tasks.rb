class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :business_process, foreign_key: true
      t.string :xml_id
      t.integer :category
      t.string :content
      t.integer :status
      t.string :assignee

      t.timestamps
    end
  end
end
