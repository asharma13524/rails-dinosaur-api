class AddCageToDinosaurs < ActiveRecord::Migration[6.1]
  def change
    add_reference :dinosaurs, :cage
  end
end
