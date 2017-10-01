class AddDiagramReferencesToBusinessProcesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_processes, :diagram, foreign_key: true
  end
end
