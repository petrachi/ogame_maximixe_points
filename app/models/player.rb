class Player < ApplicationRecord
  has_many :planets

  def produces
    effect(effect: :produces)
  end

  def stocks
    effect(effect: :stocks)
  end

  def effect effect:
    planets
      .map(&effect.to_proc)
      .inject({}) do |effect, effect_building|
        effect.merge(effect_building) do |_, a, b|
          a + b
        end
      end
  end

  def production_costs
    ProductionCostsCalculator.new(self).production_costs
  end

  def needed_storage_level
    StorageCalculator.new(self).needed_storage_level
  end
end
