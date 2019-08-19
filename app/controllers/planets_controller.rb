class PlanetsController < ApplicationController
  def create
    planet = Planet.create planet_params
    Blueprint.find_each do |blueprint|
      planet.buildings.create(blueprint: blueprint)
    end
    redirect_to planet.player
  end

  def planet_params
    params.require(:planet).permit(:player_id, :name, :temperature)
  end
end
