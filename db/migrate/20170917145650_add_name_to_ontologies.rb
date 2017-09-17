class AddNameToOntologies < ActiveRecord::Migration[5.1]
  def change
    add_column :ontologies, :name, :string
  end
end
