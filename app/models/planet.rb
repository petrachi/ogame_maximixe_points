class Planet < ApplicationRecord
  belongs_to :player
  has_many :buildings
  has_many :blueprints, through: :buildings

  def self.[] value
    find_by(name: value)
  end

  def update_ressources_since_last_production!
    now = Time.now
    update_ressources! produces_in(time: now - last_production)
    update! last_production: now
  end

  def update_ressources!(ressources)
    update! holds.merge(ressources){ |_, a, b| a + b }
  end

  def produces_in time:
    produces
      .slice(:metal, :cristal, :deuterium)
      .each_with_object({}) do |(ressource, value), acc|
        acc[ressource] = [
          value * time / 3600,
          [
            stocks[ressource] - holds[ressource],
            0,
          ].max,
        ].min
      end
  end

  def ressources
    holds.each_with_object({}) do |(ressource, hold), acc|
      acc[ressource] = {
        holds: hold,
        produces: produces[ressource],
        stocks: stocks[ressource],
      }
    end
  end

  def holds
    attributes
      .slice(*%w[metal cristal deuterium])
      .map{ |k, v| [k.to_sym, v] }
      .to_h
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
