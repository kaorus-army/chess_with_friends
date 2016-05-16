class GamesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_game, only: [:show]
  before_action :verify_game, only: [:show]
  before_action :authorize_game, only: [:show]

  def show
    @board = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  end

  private

  def set_game
    @game = Game.find_by_id(params[:id])
  end

  def verify_game
    render file: 'public/404', status: :not_found if set_game.blank?
  end

  def authorize_game
    render file: 'public/422', status: :forbidden unless @game.players.include?(current_player)
  end

end
