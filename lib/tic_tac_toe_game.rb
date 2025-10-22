require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/player'

class TicTacToeGame
  attr_accessor :player_1, :player_2

  def initialize
    @board = Board.new
    @moves = (1..9).to_a
    @players = 0
    setup_game
    begin_game
  end

  def set_player_info(player)
    print "> Please enter player's name: "
    player_name = gets.chomp
    @players += 1
    player.name = player_name.empty? ? "PLAYER #{@players}" : player_name
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

  def get_player_move(player, input_move)
    move = player.move(input_move)
    @board.update_board move[0], move[1], player.move_profile
    @moves.delete input_move
    player.is_winner = true if validate_moves(player)
  end

  def begin_game
    puts "Select a number indicating the position of your move in the board below:"
    puts @board
    puts

    has_one_winner = @player_1.is_winner || @player_2.is_winner
    @player_1.has_moved, @player_2.has_moved = false, true
    while @moves.length > 0 && !has_one_winner
      player_1_turn = @player_2.has_moved
      player_turn = player_1_turn ? @player_1 : @player_2
      puts "#{player_turn.name}'s TURN (#{player_turn.move_profile})"

      puts "MOVES LEFT: #{@moves}"
      input_move = gets.chomp
      break if input_move == 'quit'
        
      if input_move.to_i.between?(1,9) && @moves.include?(input_move.to_i)
        if player_1_turn
          get_player_move(@player_1, input_move.to_i)
          @player_1.has_moved, @player_2.has_moved = true, false
        else
          get_player_move(@player_2, input_move.to_i)
          @player_1.has_moved, @player_2.has_moved = false, true
        end
      elsif input_move.to_i == 0 || input_move.to_i > 9
        puts "INVALID MOVE! Please try again. (accepted: 1-9)"
      elsif !@moves.include?(input_move)
        puts "Move already done. Try another move."
      end

      puts @board
      puts
      break if (@player_1.is_winner || @player_2.is_winner)
      
    end
    evaluate_game
  end

  def evaluate_game
    winner = @player_1.is_winner ? @player_1 : @player_2.is_winner ? @player_2 : ""
    if @player_1.is_winner == @player_2.is_winner
      puts "THE GAME IS A DRAW"
    elsif @moves.length > 0 && !@player_1.is_winner && !@player_2.is_winner
      puts "Player already quit the game. No winner!"
    else
      puts "THE WINNER IS #{winner}"
    end
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
