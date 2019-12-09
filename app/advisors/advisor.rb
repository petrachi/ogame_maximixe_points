class Advisor
  attr_accessor :player

  def initialize player
    self.player = player
  end

  def build_list_by **options
    build_list
      .select{ |build| options.all?{ |(k, v)| build.send(k) == v } }
  end

  def best_build
    build_list
      .select{ |build| build.warnings.blank? }
      .max_by{ |a| a.percentage }
  end

  def compilers
    raise NotImplementedError
  end

  def build_list
    @build_list ||= player
      .planets
      .each_with_object([]) do |planet, acc|
        compilers.each do |compiler|
          acc << compiler.new(planet)
        end
      end
      .each{ |build| build.compile_index!(player.produces) }
      .tap do |temp_build_list|
        temp_build_list.each do |build|
          build.compile_percentage! min_index(temp_build_list)
        end
      end
      .each{ |build| build.compile_warnings! ratio: differential_ratio }
  end

  def min_index build_list
    @min_index = build_list
      .map{ |build| build.index }
      .delete_if{ |index| index == 0 || index.nan? }
      .min
  end

  def differential_ratio
    @differential_ratio ||= actual_ratio.merge(ideal_ratio, &merge_proc(:-))
  end

  def ideal_ratio
    ratio_for player.cumulative_costs
  end

  def actual_ratio
    ratio_for player.produces.slice(:metal, :cristal, :deuterium)
  end

  def ratio_for ressources
    total_ressources = ressources.values.inject(0, &:+)

    ressources.each_with_object(Hash.new(0)) do |(ressource, quantity), acc|
      acc[ressource] = quantity / total_ressources
    end
  end
end
