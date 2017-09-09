class AddBusinessProcessReferencesToLanes < ActiveRecord::Migration[5.1]
  def change
    add_reference :lanes, :business_process, foreign_key: true
  end
end
