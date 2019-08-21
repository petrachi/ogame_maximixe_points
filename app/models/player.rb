class Player < ApplicationRecord
  has_many :planets
  has_many :buildings, through: :planets do
    include Effect
  end

  delegate :costs, :produces, :stocks, to: :buildings

  def advisor
    BuilderAdvisor.new(self).call
  end

  def ressources
    effect(effect: :ressources)
  end

  def holds
    effect(effect: :holds)
  end

  def effect effect:
    planets
      .map(&effect.to_proc)
      .inject({}) do |effect, effect_building|
        effect.deep_merge(effect_building, &merge_proc(:+))
      end
  end
end
