module EffectScopes
  def costs **options
    effect(effect: :costs, **options)
  end

  def cumulative_costs **options
    effect(effect: :costs, effect_method: :cumulative_costs, **options)
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

  def cumulative_sustains **options
    effect(effect: :sustains, effect_method: :cumulative_sustains, **options)
  end

  def damages **options
    effect(effect: :damages, **options)
  end

  def effect **options
    @effect ||= Hash.new do |hash, key|
      hash[key] = compute_effect(**key)
    end
    @effect[options]
  end

  def compute_effect effect:, effect_method: nil, **options
    effect_method ||= effect
    where_effect(effect)
      .map{ |building| building.send effect_method, **options }
      .each_with_object({}) do |effect, acc|
        acc.merge!(effect, &merge_proc(:+))
      end
  end

  def where_effect(effect)
    includes(blueprint: :effects).where(blueprints: {effects: {effect: effect}})
  end
end
