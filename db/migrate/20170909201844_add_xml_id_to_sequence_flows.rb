class AddXmlIdToSequenceFlows < ActiveRecord::Migration[5.1]
  def change
    add_column :sequence_flows, :xml_id, :string
  end
end
