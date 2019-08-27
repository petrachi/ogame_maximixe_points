class Player < ApplicationRecord
  has_many :planets
  has_many :buildings, through: :planets do
    include BlueprintScopes
    include EffectScopes

    def where_effect(effect)
      super.includes(:planet, player: {researches: :blueprint})
    end
  end
  has_many :researches do
    include BlueprintScopes
    include EffectScopes
  end

  def advisor
    BuilderAdvisor.new(self)
  end

  def costs **options
    effects(effect: :costs, **options)
  end

  def produces **options
    effects(effect: :produces, **options)
  end

  def holds **options
    effects(effect: :holds, **options)
  end

  def effects effect:, **options
    buildings.send(effect, **options).merge(researches.send(effect, **options), &merge_proc(:+))
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
