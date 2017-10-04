class ChangeFkNamesFromSequenceFlow < ActiveRecord::Migration[5.1]
  def change
    rename_column :sequence_flows, :target, :target_id
    rename_column :sequence_flows, :source, :source_id
  end
end
