require 'matrix'
require 'colorize'
class TicTacToe
  def initialize()
    @winners = []
  end
  #Start the game
  def start_game(player)
    @player_a_count = 0
    @player_b_count = 0
    print "\nCreate Board, What length do you want?: ".cyan
    board_length = gets.chomp.to_i
    if board_length.nil? || board_length == 0
      puts "Invalid element, try again"
      start_game(player)
    end
    board = Array.new(board_length){|i| Array.new(board_length){|j| board_length*i+j+1 } }
    board_size = board_length * board_length
    puts "Board created!!!... \n".green
    display_board(board,board_length)
    play(board, board_size, board_length,player)
  end
  #Show the game board
  def display_board(board, length)
    count_jump = 0
    count_position = 0
    board.each do |x|
      x.each do |y|
        count_position += 1
        if count_position % length == 0
          count_jump += 1
          print y == "X" || y == "O" ? " #{add_space(y)}#{y} \n".white : " #{add_space(y)}#{y} \n".magenta
          draw_lines(length) if count_jump < length
          puts
        else
          print y == "X" || y == "O" ? " #{add_space(y)}#{y} ".white :  " #{add_space(y)}#{y} ".magenta
          print "|".magenta
        end
      end
    end
  end
  #Add space to the element depending on the number, if the number is one digit it will add a space
  def add_space(value)
    if value.to_i <= 9 || value.to_s == "X" || value.to_s == "O"
      print " "
    end
  end
  #Help to display_board to draw the board to be symmetrical
  def draw_lines(length)
    if length == 3
      14.times { print "-".magenta }
    else
      lines = (length - 3) * 5
      (14 + lines).times { print "-".magenta }
    end
  end
  #Logic of the game where the player's turn is valided
  def play(board, board_size, board_length, player)
    puts "The game has started".green
    index = player.to_i
    if player.to_i == 1
      board_size += 1
    end
    while index < board_size
      if index.odd?
        print "\nPlayer A -- Pick a number: ".cyan
        value = gets.chomp
        puts
        player_a = player_a(board, value)
        display_board(board, board_length.to_i)
        sign = "X"
        @player_a_count += 1
        if winner(board, sign, board_length)
          puts "PLAYER A - Congratulations!!! You are the winner\n".green
          @winners << "X"
          @player_a_count = 0
          break
        end
        unless player_a
          puts "Invalid number, please try again".red
          index -= 1
          @player_a_count -= 1
        end
        puts "In Draw!!!".green if (index + 1) == board_size
        @winners << "In Draw"
      else
        print "\nPlayer B -- Pick a number: ".cyan
        value = gets.chomp
        puts
        player_b = player_b(board, value)
        display_board(board, board_length.to_i)
        sign = "O"
        @player_b_count += 1
        if winner(board, sign, board_length)
          puts "PLAYER B - Congratulations!!! You are the winner\n".green
          @winners << "O"
          @player_b_count = 0
          break
        end
        unless player_b
          puts "Invalid number, please try again".red
          index -= 1
          @player_b_count -= 1
        end
        puts "In Draw!!!".green if (index + 1) == board_size
      end
      index += 1
    end
  end
  #Insert an "X" in the cell chosen by the player "player_a"
  def player_a(board, value)
    board.each.with_index do |row, i|
      row.each.with_index do |cell, j|
        if board[i][j]==value.to_i
          board[i][j] = "X"
          return true
          break
        end
      end
    end
    return false
  end
  #Insert an "O" in the cell chosen by the player "player_b"
  def player_b(board, value)
    board.each.with_index do |row, i|
      row.each.with_index do |cell, j|
        if board[i][j] == value.to_i
          board[i][j] = "O"
          return true
          break
        end
      end
    end
    return false
  end
  #Check on the board if the player won in any of the rows
  def winner_row(board, value, length)
    m_board = Matrix[*board]
    i = 0
    while i < length.to_i
      winner = m_board.row(i).all? {|v| v == value}
      if winner
        return true
        break
      end
      i += 1
    end
  end
  #Check on the board if the player won in any of the columns
  def winner_column(board, value, length)
    m_board = Matrix[*board]
    i = 0
    while i < length.to_i
      winner = m_board.column(i).all? {|v| v == value}
      if winner
        return true
        break
      end
      i += 1
    end
  end
  #check on the board if the player won on the main diagonal
  def winner_diagonal(board, value, length)
    m_board = Matrix[*board]
    count = 0
    m_board.each_with_index do |e, row, col|
      if row == col
        if e == value
          count += 1
        end
      end
    end
    return true if count == length.to_i
  end
  #check on the board if the player won the reverse diagonal
  def winner_diagonal_inverse(board, value, length)
    m_board = Matrix[*board]
    count = 0
    m_board.square? && (0...m_board.row_size).each do |i|
      if m_board[i, m_board.row_size - 1 - i] == value
        count += 1
        if count == length.to_i
          return true
          break
        end
      end
    end
  end
  #returns true if there is a winner
  def winner(board, value, length)
    if winner_row(board, value, length) || winner_column(board, value, length) || winner_diagonal(board, value, length) || winner_diagonal_inverse(board, value, length)== true
      return true
    end
  end
  #Shows how many times a player has won
  def check_winners
    winner_x = @winners.count('X')
    winner_o = @winners.count('O')
    puts "X has won #{winner_x} times"
    puts "O has won #{winner_o} times"
  end
  #Shows the player that will start the next game
  def turns
    player_a = @player_a_count; # 1
    player_b = @player_b_count; # 0
    if player_a == 0
      return 0
    elsif player_b == 0
      return 1
    else
      if player_a < player_b
        return 1
      else
        return 0
      end
    end
  end
end
