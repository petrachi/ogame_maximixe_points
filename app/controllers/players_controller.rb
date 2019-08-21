class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def create
    player = Player.create player_params
    redirect_to player
  end

  def show
    set_player
    @player.planets.each(&:update_ressources_since_last_production!)
  end

  def advisor
    set_player
    @player.planets.each(&:update_ressources_since_last_production!)
  end

  def set_player
    @player = Player
      .includes(
        planets: {buildings: :blueprint}
      )
      .find_by id: params[:id]
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
