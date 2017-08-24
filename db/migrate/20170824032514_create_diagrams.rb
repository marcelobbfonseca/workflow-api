class CreateDiagrams < ActiveRecord::Migration[5.1]
  def change
    create_table :diagrams do |t|
      t.string :name

      t.timestamps
    end
  end
end
