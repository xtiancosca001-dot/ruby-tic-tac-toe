# Player Object Class File
class Player
  attr_accessor :name, :moves

  def initialize(name)
    @name = name
    @moves = []
  end

  def move(position)
    raise 'Move not acceptable, only numbers are allowed (1-9)' unless (position.to_i.between?(1,9))
    @moves << position
  end

  # TODO: Figure out a way to save a winner flag for a player
end