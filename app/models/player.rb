class Player < ApplicationRecord
  has_many :planets

  def ressources
    effect(effect: :ressources)
  end

  def holds
    effect(effect: :holds)
  end

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
        effect.deep_merge(effect_building) do |_, a, b|
          a + b
        end
      end
  end
end
