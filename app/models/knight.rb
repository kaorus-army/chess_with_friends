class Knight < Piece
  
  def valid_move?(end_coord)

    end_x_pos = end_coord[0]
    end_y_pos = end_coord[1]
    #Check valid coordinates
    return false unless game.valid_coordinate?(end_coord)
    #Check move is not a stright line
    return false if valid_move_direction?(end_coord)
    #Check that move is 2 x 1 spaces
    return false if (self.x_pos - end_x_pos).abs + (self.y_pos - end_y_pos).abs != 3

    true
  end
end
