class Pawn < Piece
  # This piece should have limits on its behavior:
  # - can only move one space at a time (unless its moves_made is zero)
  # - can only move in the vertical direction
  def correct_vector?(end_coord)
    if color == "black"
      end_coord[1] > y_pos
    else
      end_coord[1] < y_pos
    end
  end

  def valid_move?(end_coord)
    valid_distance = valid_move_direction?(end_coord) ? (distance_from(end_coord, get_move_direction(end_coord)) <= 2) : false
    valid_coordinate = game.valid_coordinate?(end_coord) && (coordinate != end_coord)

    if valid_move_direction?(end_coord) && valid_distance && valid_coordinate && ! obstructed?(end_coord) && correct_vector?(end_coord)
      if get_move_direction(end_coord) == :vertical
        if moves_made == 0
          true
        else
          if distance_from(end_coord, :vertical) == 1
            true
          else
            false
          end
        end
      else
        false
      end
    else
      false
    end
  end
end
