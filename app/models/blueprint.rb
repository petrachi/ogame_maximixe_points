class Blueprint < ApplicationRecord
  has_many :effects
  has_many :buildings
  has_many :researchess

  def self.[] value
    find_by(name: value)
  end

  def produces(**options)
    effects_values(effect: :produces, **options)
  end

  def stocks(**options)
    effects_values(effect: :stocks, **options)
  end

  def costs(**options)
    effects_values(effect: :costs, **options)
  end

  def sustains(**options)
    effects_values(effect: :sustains, **options)
  end

  def damages(**options)
    effects_values(effect: :damages, **options)
  end

  def effects_values(effect:, **options)
    effects.each_with_object({}) do |building_effect, acc|
      if building_effect.effect == effect
        acc[building_effect.ressource] = building_effect.quantity_for(**options)
      end
    end
  end
end
