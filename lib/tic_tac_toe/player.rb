# Player Object Class File
class Player
  attr_accessor :name, :moves, :move_profile

  def initialize(name, move_profile)
    @name = name
    raise "move_profile is not accepted (Entered #{move_profile}), acceptable: x / o" unless (move_profile == 'o' || move_profile == 'x')
    @move_profile = move_profile
    @moves = []
  end

  def move(position)
    raise 'Move not acceptable, only numbers are allowed (1-9)' unless (position.to_i.between?(1,9))
    @moves << move_map[position]
    move_map[position]
  end

  def current_move
    @moves.last
  end

  # TODO: Figure out a way to save a winner flag for a player
  
  private
  def move_map
    [
      nil, [0,0], [0,1], [0,2],
      [1,0], [1,1], [1,2],
      [2,0], [2,1], [2,2]
    ]
  end
end