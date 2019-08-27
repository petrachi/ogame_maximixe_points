class ArtilleryCostsCalculator < BaseCostsCalculator
  Dir[Rails.root.join("app/costs_calculators/artillery_costs_calculator/*.rb")]
    .each { |f| require_dependency f }

  DEFCON_LEVEL = 1.0

  def self.artillery_mix_ratio
    {
      missile: 500,
      laser: 100,
      heavy_laser: 25,
      gauss: 4,
      ion: 8,
      plasma: 1,
    }
  end

  def self.artillery_mix level: 1
    artillery_mix_ratio
      .each_with_object([]) do |(ressource, quantity), acc|
        acc << Building.new(
          blueprint: Blueprint["#{ressource}_artillery"],
          level: (quantity * level * DEFCON_LEVEL).ceil,
        )
      end
      .tap do |acc|
        acc.class_eval do
          def costs
            effect effect: :costs
          end

          def sustains
            effect effect: :sustains
          end

          def effect effect:
            map{ |building| building.send effect }
              .each_with_object({}) do |effect, acc|
                acc.merge!(effect, &merge_proc(:+))
              end
          end
        end
      end
  end
end
