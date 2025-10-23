require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/player'

class TicTacToeGame
  attr_writer :player1, :player2

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
    player_move_profile = ''
    puts "\nEnter a valid move profile (acceptable: x / o)"
    while player_move_profile != 'o' && player_move_profile != 'x'
      print '> Move: '
      player_move_profile = gets.chomp
    end
    player2_move_profile = player_move_profile == 'x' ? 'o' : 'x'
    puts "P1: #{player_move_profile} | P2: #{player2_move_profile}"
    [player_move_profile, player2_move_profile]
  end

  def setup_game
    puts '============='
    puts '=TIC TAC TOE='
    puts "=============\n"

    # Player 1 entry
    puts '==PLAYER 1=='
    @player1 = Player.new
    set_player_info(@player1)

    # Player 2 entry
    puts '==PLAYER 2=='
    @player2 = Player.new
    set_player_info(@player2)

    # player profile
    puts '==PLAYER PROFILE=='
    player_profiles = set_player_profiles
    @player1.move_profile, @player2.move_profile = player_profiles
  end

  def to_s
    "Player 1 (#{@player1.move_profile}): #{@player1.name} | Player 2 (#{@player2.move_profile}): #{@player2.name}"
  end

  def get_player_move(player, input_move)
    move = player.move(input_move)
    @board.update_board move[0], move[1], player.move_profile
    @moves.delete input_move
    player.is_winner = true if validate_moves(player)
  end

  def begin_game
    puts 'Select a number indicating the position of your move in the board below:'
    puts @board
    puts

    has_one_winner = @player1.is_winner || @player2.is_winner
    @player1.has_moved = false
    @player2.has_moved = true
    while @moves.length.positive? && !has_one_winner
      player1_turn = @player2.has_moved
      player_turn = player1_turn ? @player1 : @player2
      puts "#{player_turn.name}'s TURN (#{player_turn.move_profile})"

      puts "MOVES LEFT: #{@moves}"
      print "> Enter a number to move (type 'quit' to exit): "
      input_move = gets.chomp
      break if input_move == 'quit'

      if input_move.to_i.between?(1, 9) && @moves.include?(input_move.to_i)
        if player1_turn
          get_player_move(@player1, input_move.to_i)
          @player1.has_moved = true
          @player2.has_moved = false
        else
          get_player_move(@player2, input_move.to_i)
          @player1.has_moved = false
          @player2.has_moved = true
        end
      elsif input_move.to_i.zero? || input_move.to_i > 9
        puts 'INVALID MOVE! Please try again. (accepted: 1-9)'
      elsif !@moves.include?(input_move)
        puts 'Move already done. Try another move.'
      end

      puts @board
      puts
      break if @player1.is_winner || @player2.is_winner

    end
    evaluate_game
  end

  def evaluate_game
    winner = if @player1.is_winner
               @player1
             else
               @player2.is_winner ? @player2 : ''
             end
    if @player1.is_winner == @player2.is_winner && @moves.empty?
      puts 'THE GAME IS A DRAW'
    elsif @moves.length.positive? && !@player1.is_winner && !@player2.is_winner
      puts 'Game is exited... No winner!'
    else
      puts "THE WINNER IS #{winner}"
    end
  end

  private

  def winning_moves
    %w[369 159 123 789 357 456 147 258]
  end

  def validate_moves(player)
    winning_moves.each do |winning_move|
      common_move = ''
      moves = winning_move.chars
      moves.each do |move|
        player.moves.each do |player_move|
          common_move += player_move.to_s if move == player_move.to_s && !common_move.include?(player_move.to_s)
        end
      end
      return true if common_move == winning_move
    end
    false
  end
end
