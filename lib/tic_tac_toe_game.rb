require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/player'

class TicTacToeGame
  attr_accessor :player_1, :player_2

  def initialize
    @player_1 = Player.new(nil, 'x')
    @player_2 = Player.new(nil, 'o')
    @board = Board.new
    @moves = (1..9).to_a
  end

  def setup_game
    puts "============="
    puts "=TIC TAC TOE="
    puts "=============\n"

    # Player entry
    print "> Please enter first player's name (x): "
    player_1_name = gets.chomp
    @player_1.name = player_1_name.empty? ? "PLAYER 1" : player_1_name
    print "> Please enter second player's name (o): "
    player_2_name = gets.chomp 
    @player_2.name = player_2_name.empty? ? "PLAYER 2" : player_2_name
  end

  def to_s
    "Player 1 (x): #{@player_1.name} | Player 2 (o): #{@player_2.name}"
  end

  def begin_game
    puts "Select a number indicating the position of your move in the board below:"
    puts @board

    1.upto(9) do |turn|
      puts "MOVES LEFT: #{@moves}"
      unless turn % 2 == 0
        puts "#{@player_1.name}'s TURN (x)"
        input_move = gets.chomp.to_i
        move = @player_1.move(input_move)
        @board.update_board move[0], move[1], @player_1.move_profile
        if validate_moves(@player_1)
          @player_1.is_winner = true
          break
        end
      else  
        puts "#{@player_2.name}'s TURN (o)"
        input_move = gets.chomp.to_i
        move = @player_2.move(input_move)
        @board.update_board move[0], move[1], @player_2.move_profile
        if validate_moves(@player_2)
          @player_2.is_winner = true
          break
        end
      end
      @moves.delete input_move
      puts @board
      puts
    end

    evaluate_game
  end

  private
  def winning_moves
    ["369", "159", "123", "789", "357", "456", "147", "258"]
  end

  def validate_moves(player)
    winning_moves.each do |winning_move|
      common_move = ""
      moves = winning_move.split("")
      moves.each do |move|
        player.moves.each do |player_move|
          common_move += player_move.to_s if move == player_move.to_s && !common_move.include?(player_move.to_s)
        end
      end
      return true if common_move == winning_move
    end
    return false
  end
end

g = TicTacToeGame.new
puts g
g.setup_game
puts g
g.begin_game
