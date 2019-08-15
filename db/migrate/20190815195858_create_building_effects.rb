class CreateBuildingEffects < ActiveRecord::Migration[5.1]
  def change
    create_table :building_effects do |t|
      t.string :ressource
      t.string :effect
      t.string :quantity
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
