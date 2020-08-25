class Board
  LINE = '-----'.freeze
  def initialize
    @board_positions = { a1: 1, a2: 2, a3: 3, b1: 4, b2: 5, b3: 6, c1: 7, c2: 8, c3: 9 } # sets initial position
  end

  def print_board
    puts "#{@board_positions[:a1]}|#{@board_positions[:a2]}|#{@board_positions[:a3]}"
    puts LINE
    puts "#{@board_positions[:b1]}|#{@board_positions[:b2]}|#{@board_positions[:b3]}"
    puts LINE
    puts "#{@board_positions[:c1]}|#{@board_positions[:c2]}|#{@board_positions[:c3]}"
    puts " "
  end

  def change_position(position, current_player_token)
    @board_positions[position] = current_player_token
  end

  def winner?
    return true if @board_positions[:a1] == @board_positions[:a2] && @board_positions[:a2] == @board_positions[:a3]
    return true if @board_positions[:b1] == @board_positions[:b2] && @board_positions[:b2] == @board_positions[:b3]
    return true if @board_positions[:c1] == @board_positions[:c2] && @board_positions[:c2] == @board_positions[:c3]
    return true if @board_positions[:a1] == @board_positions[:b1] && @board_positions[:b1] == @board_positions[:c1]
    return true if @board_positions[:a2] == @board_positions[:b2] && @board_positions[:b2] == @board_positions[:c2]
    return true if @board_positions[:a3] == @board_positions[:b3] && @board_positions[:b3] == @board_positions[:c3]
    return true if @board_positions[:a1] == @board_positions[:b2] && @board_positions[:b2] == @board_positions[:c3]
    return true if @board_positions[:a3] == @board_positions[:b2] && @board_positions[:b2] == @board_positions[:c1]
  end

  def make_play(player)
    play_position = 0
    while play_position == 0
      puts "#{player.name}, enter the position of the board where you want to play:  "
      desired_position = gets.chomp.to_i
      if @board_positions.has_value?(desired_position)
        play_position = @board_positions.key(desired_position)
      else
        puts 'That is not a valid position!'
      end
    end
    change_position(play_position, player.token)
    puts ' '
  end

  def start_game
    puts "Let's play Tic Tac Toe!"
    set_players
    current_turn_count = 1
    until winner? || draw?(current_turn_count)
      print_board
      current_turn_count.odd? ? make_play(@first_player) : make_play(@second_player)
      current_turn_count += 1
    end
    if winner?
      (current_turn_count - 1).odd? ? game_over(@first_player) : game_over(@second_player)
    end
  end

  def draw?(turn)
    if turn == 10
      print_board
      puts "It's a draw! Better luck next time!"
      return true
    else
      return false
    end
  end

  def game_over(player)
    print_board
    puts "Congratulation #{player.name}, you won!"
  end

  def set_players
    puts "What's the first player name?"
    @first_player = Player.new(gets.chomp, 'X')
    puts "What's the second player name?"
    @second_player = Player.new(gets.chomp, 'O')
    puts ' '
  end

end

class Player
  attr_reader :token, :name
  def initialize(name, token)
    @name = name
    @token = token
  end
end


board = Board.new
board.start_game
