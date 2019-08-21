class PlanetsController < ApplicationController
  def create
    planet = Planet.create planet_params
    Blueprint.find_each do |blueprint|
      planet.buildings.create(blueprint: blueprint)
    end
    redirect_to planet.player
  end

  def update
    set_planet
    @planet.update! planet_params
    redirect_back(fallback_location: player_path(@planet.player))
  end

  def set_planet
    @planet = Planet.find_by id: params[:id]
  end

  def planet_params
    params.require(:planet).permit(:player_id, :name, :temperature, :metal, :cristal, :deuterium)
  end
end
