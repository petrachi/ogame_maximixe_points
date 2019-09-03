class PlanetsController < ApplicationController
  def create
    planet = Planet.create planet_params
    Blueprint.where('name ~* ?', /^((?!tech|rocket).)*$/.source).each do |blueprint|
      planet.buildings.create(blueprint: blueprint, level: 0)
    end
    redirect_to planet.player
  end

  def edit
    render :edit, locals: {planet: find_planet}
  end

  def update
    planet = find_planet
    planet.update! planet_params

    planet.buildings.includes(:blueprint).each do |building|
      building.update level: params[building.blueprint.name].to_i
    end

    redirect_to planet.player
  end

  def find_planet
    Planet.find_by id: params[:id]
  end

  def planet_params
    params.require(:planet).permit(:player_id, :name, :temperature, :size)
  end
end
