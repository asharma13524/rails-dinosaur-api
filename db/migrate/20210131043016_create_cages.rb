class CreateCages < ActiveRecord::Migration[6.1]
  def change
    create_table :cages do |t|
      t.string :cage_status
      t.string :cage_type
      t.string :species
      t.integer :max_dinosaurs
      t.timestamps
    end
  end
end
