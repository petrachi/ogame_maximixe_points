class CreateEffects < ActiveRecord::Migration[5.1]
  def change
    create_table :effects do |t|
      t.string :ressource
      t.string :effect
      t.string :quantity
      t.references :blueprint, foreign_key: true

      t.timestamps
    end
  end
end
