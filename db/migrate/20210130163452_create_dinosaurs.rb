class CreateDinosaurs < ActiveRecord::Migration[6.1]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.string :diet

      t.timestamps
    end
  end
end
