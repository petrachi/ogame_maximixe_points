class CreateBuilds < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore'

    create_table :builds do |t|
      t.integer :produces
      t.hstore :costs
      t.string :uid

      t.boolean :compiled, default: false

      t.timestamps
    end
  end
end
