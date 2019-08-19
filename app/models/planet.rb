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
    }.merge(
      production_since_last_production time_since_last_production: now - last_production
    ) do |ressource, a, b|
      [a + b, stocks[ressource]].min
    end

    update_params.slice!(:metal, :cristal, :deuterium)
    update_params[:last_production] = now
    update update_params
  end

  def production_since_last_production time_since_last_production:
    produces
      .slice(:metal, :cristal, :deuterium)
      .each_with_object({}) do |(ressource, value), acc|
        acc[ressource] = value * time_since_last_production / 3600
      end
  end

  def ressources
    holds = self.holds
    produces = self.produces
    stocks = self.stocks

    p holds
    p produces
    p "---"

    holds.each_with_object({}) do |(ressource, hold), acc|
      acc[ressource] = {
        holds: hold,
        produces: produces[ressource],
        stocks: stocks[ressource],
      }
    end
  end

  def holds
    attributes.slice(*%w[metal cristal deuterium]).map{ |k, v| [k.to_sym, v] }.to_h
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
      .inject({}.with_indifferent_access) do |effect, effect_building|
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
