class ResearchCostsCalculator::ByRessource::Energy < ResearchCostsCalculator::ByRessource
  def produces
    energy_increase = self.energy_increase
    produces_for_one
      .each_with_object({}) do |(ressource, quantity), acc|
        acc[ressource] = quantity * energy_increase
      end
      .values
      .inject(0, &:+)
  end

  def produces_for_one
    energy = player
      .buildings
      .where_name(['solar_plant', 'fusion_plant'])
      .produces
      .[](:energy)

    player
      .produces
      .slice(:metal, :cristal, :deuterium)
      .each_with_object({}) do |(ressource, quantity), acc|
        acc[ressource] = quantity / energy
      end
  end

  def energy_increase
    player
      .produces(modifiers: {energy_tech: 1})
      .merge(player.produces, &merge_proc(:-))
      .[](:energy)
  end
end
