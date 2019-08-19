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
    @player.planets.each(&:update_ressources!)
  end

  def set_player
    @player = Player.find_by id: params[:id]
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
