require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/player'

class TicTacToeGame
  attr_accessor :player_1, :player_2

  def initialize
    @board = Board.new
    @moves = (1..9).to_a
    setup_game
  end

  def set_player_info(player)
    print "> Please enter player's name: "
    player = Player.new
    player_name = gets.chomp
    player.name = player_name.empty? ? "PLAYER 1" : player_name
  end

  def set_player_profiles
    print "> Please enter player 1's profile (x / o): "
    player_move_profile = ""
    puts "\nEnter a valid move profile (acceptable: x / o)"
    while player_move_profile != 'o' && player_move_profile != 'x'
      print "> Move: "
      player_move_profile = gets.chomp
    end
    player_2_move_profile = player_move_profile == 'x' ? 'o' : 'x'
    puts "P1: #{player_move_profile} | P2: #{player_2_move_profile}"
    [player_move_profile, player_2_move_profile]
  end

  def setup_game
    puts "============="
    puts "=TIC TAC TOE="
    puts "=============\n"

    # Player 1 entry
    puts "==PLAYER 1=="
    @player_1 = Player.new
    set_player_info(@player_1)

    # Player 2 entry
    puts "==PLAYER 2=="
    @player_2 = Player.new
    set_player_info(@player_2)

    # player profile
    puts "==PLAYER PROFILE=="
    player_profiles = set_player_profiles
    @player_1.move_profile, @player_2.move_profile = player_profiles
  end

  def to_s
    "Player 1 (x): #{@player_1.name} | Player 2 (o): #{@player_2.name}"
  end

  def get_player_move(player)
    puts "#{player.name}'s TURN (#{player.move_profile})"
    input_move = gets.chomp.to_i
    move = player.move(input_move)
    @board.update_board move[0], move[1], player.move_profile
    player.is_winner = true if validate_moves(player)
  end

  def begin_game
    puts "Select a number indicating the position of your move in the board below:"
    puts @board

    1.upto(9) do |turn|
      puts "MOVES LEFT: #{@moves}"
      unless turn % 2 == 0
        get_player_move(@player_1)
      else  
        get_player_move(@player_2)
      end
      break if @player_1.is_winner || @player_2.is_winner
      @moves.delete input_move
      puts @board
      puts
    end

    evaluate_game
  end

  def evaluate_game
    winner = @player_1.is_winner ? @player_1 : @player_2.is_winner ? @player_2 : ""
    puts @player_1.is_winner == @player_2.is_winner ? "THE GAME IS A DRAW" : "THE WINNER IS #{winner}"
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
