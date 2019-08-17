class Planet < ApplicationRecord
  belongs_to :player
  has_many :buildings
  has_many :blueprints, through: :buildings

  def self.[] value
    find_by(name: value)
  end

  def update_ressources!
    now = Time.now

    update_params = {
      metal: metal,
      cristal: cristal,
      deuterium: deuterium,
    }.merge(production_since_last_production time_since_last_production: now - last_production) do |_, a, b|
      a + b
    end
    update_params.slice!(:metal, :cristal, :deuterium)
    update_params[:last_production] = now
    update update_params
  end

  def production_since_last_production time_since_last_production:
    produces.inject({}) do |production_since_last_production, (ressource, value)|
      production_since_last_production[ressource] = value * time_since_last_production / 3600
      production_since_last_production
    end
  end

  def produces
    effect(effect: :produces)
  end

  def stocks
    effect(effect: :stocks)
  end

  def effect effect:
    effect_buildings(effect: effect)
      .map(&effect.to_proc)
      .inject({}) do |effect, effect_building|
        effect.merge(effect_building) do |_, a, b|
          a + b
        end
      end
  end

  def effect_buildings effect:
    buildings
      .includes(blueprint: :building_effects)
      .where(blueprints: {building_effects: {effect: effect}})
  end
end
