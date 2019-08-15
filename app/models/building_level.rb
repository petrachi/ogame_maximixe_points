class BuildingLevel < ApplicationRecord
  belongs_to :planet
  belongs_to :building
  has_many :building_effects, through: :building

  def produces
    production_effects.inject({}) do |produces, effect|
      produces[effect.ressource] = effect.quantity_for(level: level)
      produces
    end
  end

  def production_effects
    building_effects
      .where(effect: 'produces')
  end

  def costs
    costs_effects.inject({}) do |costs, effect|
      costs[effect.ressource] = effect.quantity_for(level: level)
      costs
    end
  end

  def costs_effects
    building_effects
      .where(effect: 'costs')
  end
end
