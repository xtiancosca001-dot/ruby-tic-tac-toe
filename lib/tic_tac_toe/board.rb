class Board
  ROWS = COLUMNS = 3

  @@moves = [
    ['1','2','3'],
    ['4','5','6'],
    ['7','8','9']
  ]

  def self.clear_board
    @@moves = [
      ['1','2','3'],
      ['4','5','6'],
      ['7','8','9']
    ]
  end

  def self.update_board(x,y,value)
    raise "x position is out of range (entered #{x})" unless x < ROWS
    raise "y position is out of range (entered #{y})" unless y < COLUMNS
    raise "Value is not acceptable (entered #{value}) (only: x / o)" unless (value == 'o' || value == 'x')
    @@moves[x][y] = value
  end

  def self.to_s
    grid = "+---+---+---+\n"
    @@moves.each do |line|
      grid += "| #{line.join(" | ")} |\n"
      grid += "+---+---+---+\n"
    end
    grid
  end
end