class GamesController < ApplicationController


def show
  @game = Game.new
  @piece = Piece.new
  @board = [[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
end

end
