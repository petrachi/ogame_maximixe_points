class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.integer :level
      t.references :planet, foreign_key: true
      t.references :blueprint, foreign_key: true

      t.timestamps
    end
  end
end
