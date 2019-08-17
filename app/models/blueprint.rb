class Blueprint < ApplicationRecord
  has_many :building_effects
  has_many :buildings
  has_many :planets, through: :buildings

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

  def effects_values(effect:, **options)
    effects(effect: effect).inject({}) do |effects_values, effect|
      effects_values[effect.ressource] = effect.quantity_for(**options)
      effects_values
    end
  end

  def effects(effect:)
    building_effects
      .where(effect: effect)
  end
end
