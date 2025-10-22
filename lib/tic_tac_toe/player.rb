# Player Object Class File
class Player
  attr_accessor :name, :moves, :move_profile, :is_winner, :has_moved

  def initialize(name = '', move_profile = '')
    @name = name
    @is_winner = false
    @move_profile = move_profile
    @moves = []
    @has_moved = false
  end

  def move(position)
    raise 'Move not acceptable, only numbers are allowed (1-9)' unless position.to_i.between?(1, 9)

    @moves << position
    move_map[position]
  end

  def to_s
    "#{@name} (#{@move_profile})"
  end

  private

  def move_map
    [
      nil, [0, 0], [0, 1], [0, 2],
      [1, 0], [1, 1], [1, 2],
      [2, 0], [2, 1], [2, 2]
    ]
  end
end
