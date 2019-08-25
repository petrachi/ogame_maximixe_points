class CreateResearches < ActiveRecord::Migration[5.1]
  def change
    create_table :researches do |t|
      t.integer :level
      t.references :player, foreign_key: true
      t.references :blueprint, foreign_key: true

      t.timestamps
    end
  end
end
