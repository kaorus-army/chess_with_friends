class Queen < Piece
  # - can move in any direction for unlimited distance
  def vaild_move?(end_coords)

    return false unless game.valid_coordinate?(end_coord)

    return false if obstructed?(end_coord)

    true
    
  end
end
