class CreateOntologies < ActiveRecord::Migration[5.1]
  def change
    create_table :ontologies do |t|
      t.string :path_name

      t.timestamps
    end
  end
end
