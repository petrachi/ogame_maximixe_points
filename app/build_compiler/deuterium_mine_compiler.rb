class DeuteriumMineCompiler < MineCompiler
  def ressource
    :deuterium
  end

  def uid
    "#{ blueprint_name } #{ building.level }, #{ planet.buildings["solar_plant"].level }, #{ planet.buildings["fusion_plant"].level }, #{ planet.buildings["deuterium_mine"].level }, #{ planet.temperature}"
  end
end
