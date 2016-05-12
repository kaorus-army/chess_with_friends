class King < Piece
  # - can only move one total space
  # - can move in any direction

  def valid_move?(end_coord)

    return false unless valid_move_direction?(end_coord) && game.vaild_coordinate?(end_coord)
    
    direction = get_move_direction(end_coord)
    distance = distance_from(end_coord, direction)


    if distance == 1
      true
    else
      false
    end
  end

end
