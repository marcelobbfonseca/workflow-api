class CreateDiagrams < ActiveRecord::Migration[5.1]
  def change
    create_table :diagrams do |t|
      t.string :name
      t.string :file
      t.string :image

      t.timestamps
    end
  end
end
