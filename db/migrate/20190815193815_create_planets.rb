class CreatePlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :planets do |t|
      t.string :name
      t.integer :temperature
      t.integer :size

      t.integer :metal, default: 0
      t.integer :cristal, default: 0
      t.integer :deuterium, default: 0
      t.datetime :last_production, default: Time.now

      t.references :player

      t.timestamps
    end
  end
end
