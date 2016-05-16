class GamesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_game, only: [:show, :join, :destroy]
  before_action :verify_game, only: [:show, :join, :destroy]
  before_action :authorize_game, only: [:show, :destroy]

  def index
    @games = Game.all
  end

  def show
    @board = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  end

  def new
  end

  def create
    @game = Game.new(game_params)
    @game.save(validate: false)                             # Game validates presence of players, so have to soft-save before checking validations
    @game.playerships.create(player: current_player)

    if @game.valid?
      redirect_to game_url(@game)
    else
      @game.destroy
      render :new, status: :unprocessable_entity
    end
  end

  def join
    if @game.players.include?(current_player)               # Player has already joined this game
      redirect_to game_url(@game)
    elsif @game.players.count >= 2                          # Game already has 2 players
      redirect_to games_url
    else                                                    # Join up!
      @game.playerships.create(player: current_player, color: 'black')      # First player will default to white, joining player should be black
      redirect_to game_url(@game)
    end
  end

  def destroy
    # Decide what to do based on the current player's color
    case current_player.playerships.where(game_id: @game.id).first.color
    when 'white'
      @game.delete_request_white = true
    when 'black'
      @game.delete_request_black = true
    end
    @game.save!

    # If both delete requests are true, destroy the game
    @game.destroy if @game.delete_request_white && @game.delete_request_black

    # Always redirect to the the game index
    redirect_to games_url
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

  def game_params
    params[:game][:status] = 'start'
    params[:game][:moves_made] = 0
    params.require(:game).permit(:nickname, :status, :moves_made)
  end

end
