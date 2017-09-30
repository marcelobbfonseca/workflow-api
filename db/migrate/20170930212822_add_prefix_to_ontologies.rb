class AddPrefixToOntologies < ActiveRecord::Migration[5.1]
  def change
    add_column :ontologies, :prefix, :string
  end
end
