class CreateBuildingLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :building_levels do |t|
      t.integer :level
      t.references :planet, foreign_key: true
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
