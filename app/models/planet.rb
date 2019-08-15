class Planet < ApplicationRecord
  belongs_to :player
  has_many :building_levels
  has_many :buildings, through: :building_levels

  def self.[] value
    find_by(name: value)
  end

  def production
    production_buildings
      .map(&:produces)
      .inject({}) do |production, building_production|
        production.merge(building_production) do |_, a, b|
          a + b
        end
      end
  end

  def production_buildings
    building_levels
      .includes(building: :building_effects)
      .where(buildings: {building_effects: {effect: 'produces'}})
  end
end
