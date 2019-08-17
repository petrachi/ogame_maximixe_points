class CreateBlueprints < ActiveRecord::Migration[5.1]
  def change
    create_table :blueprints do |t|
      t.string :name

      t.timestamps
    end
  end
end
