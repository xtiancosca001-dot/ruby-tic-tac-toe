# This is a 3x3 game board for tic tac toe
class Board
  ROWS = COLUMNS = 3

  def initialize
    @moves = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9]
    ]
  end

  def clear_board
    @moves = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9]
    ]
  end

  def update_board(x_position, y_position, value)
    raise "x position is out of range (entered #{x_position})" unless x_position < ROWS
    raise "y position is out of range (entered #{y_position})" unless y_position < COLUMNS
    raise "Value is not acceptable (entered #{value}) (only: x / o)" unless %w[o x].include?(value)

    @moves[x_position][y_position] = value
  end

  def to_s
    grid = "+---+---+---+\n"
    @moves.each do |line|
      grid += "| #{line.join(' | ')} |\n"
      grid += "+---+---+---+\n"
    end
    grid
  end
end
