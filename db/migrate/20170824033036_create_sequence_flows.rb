class CreateSequenceFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :sequence_flows do |t|
      t.integer :target
      t.integer :source

      t.timestamps
    end
  end
end
