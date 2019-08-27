module EffectScopes
  def costs **options
    effect(effect: :costs, **options)
  end

  def produces **options
    effect(effect: :produces, **options)
  end

  def stocks **options
    effect(effect: :stocks, **options)
  end

  def sustains **options
    effect(effect: :sustains, **options)
  end

  def damages **options
    effect(effect: :damages, **options)
  end

  def effect effect:, **options
    where_effect(effect)
      .map{ |building| building.send effect, **options }
      .each_with_object({}) do |effect, acc|
        acc.merge!(effect, &merge_proc(:+))
      end
  end

  def where_effect(effect)
    includes(blueprint: :effects).where(blueprints: {effects: {effect: effect}})
  end
end
