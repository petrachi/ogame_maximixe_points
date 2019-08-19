class Player < ApplicationRecord
  has_many :planets

  def ressources
    planets.each_with_object(Hash.new(0)) do |planet, acc|
      acc[:metal] += planet.metal
      acc[:cristal] += planet.cristal
      acc[:deuterium] += planet.deuterium
    end
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
        effect.merge(effect_building) do |_, a, b|
          a + b
        end
      end
  end
end
