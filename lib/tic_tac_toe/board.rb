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

  def update_board(x, y, value)
    raise "x position is out of range (entered #{x})" unless x < ROWS
    raise "y position is out of range (entered #{y})" unless y < COLUMNS
    raise "Value is not acceptable (entered #{value}) (only: x / o)" unless %w[o x].include?(value)

    @moves[x][y] = value
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
