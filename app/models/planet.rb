class Planet < ApplicationRecord
  belongs_to :player
  has_many :buildings do
    include BlueprintScopes
    include EffectScopes

    def where_effect(effect)
      super.includes(:planet, player: {researches: :blueprint})
    end
  end
  has_many :blueprints, through: :buildings

  def self.[] value
    find_by(name: value)
  end

  delegate :costs, :cumulative_costs, :produces, :stocks, to: :buildings

  # def update_ressources_since_last_production!
  #   now = Time.now
  #   update_ressources! produces_in(time: now - last_production)
  #   update! last_production: now
  # end
  #
  # def update_ressources!(ressources)
  #   update! holds.merge(ressources, &merge_proc(:+))
  # end
  #
  # def produces_in time:
  #   produces
  #     .slice(:metal, :cristal, :deuterium)
  #     .each_with_object({}) do |(ressource, value), acc|
  #       acc[ressource] = [
  #         value * time / 3600,
  #         [
  #           stocks[ressource] - holds[ressource],
  #           0,
  #         ].max,
  #       ].min
  #     end
  # end

  # def ressources
  #   holds.each_with_object({}) do |(ressource, hold), acc|
  #     acc[ressource] = {
  #       holds: hold,
  #       produces: produces[ressource],
  #       stocks: stocks[ressource],
  #     }
  #   end
  # end

  # def holds
  #   attributes
  #     .slice(*%w[metal cristal deuterium])
  #     .map{ |k, v| [k.to_sym, v] }
  #     .to_h
  # end

  # def energy_efficiency(extra_consumption: 0)
  #   if produces[:energy] > extra_consumption
  #     1.0
  #   else
  #     energy_production = buildings.where_name(['solar_plant', 'fusion_plant']).produces[:energy]
  #     energy_consumption = energy_production - produces[:energy] + extra_consumption
  #     energy_production / energy_consumption
  #   end
  # end
end
