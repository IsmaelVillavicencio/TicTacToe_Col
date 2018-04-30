require "TicTacToe_Col/version"
require 'colorize'
require 'ttt'

module TicTacToeCol
  @@ttt = TicTacToe.new
  def start
    loop do
      puts " ------------- MENU ------------- ".cyan
      puts "|  [1] Play Tic Tac Toe          |".cyan
      puts "|  [2] Exit                      |".cyan
      puts " -------------------------------- ".cyan
      first_menu = gets.chomp.to_i
      case first_menu
        when 1
          default_player = 1
          @@ttt.start_game(default_player)
          player = @@ttt.turns
          loop do
            puts  "-------------------------------------- ".cyan
            puts  "|  Do you want to start a new game?   |".cyan
            puts  "|  [1] Continue                       |".cyan
            puts  "|  [2] Show Scoreboard                |".cyan
            puts  "|  [3] Return to first menu           |".cyan
            puts  "-------------------------------------- ".cyan
            second_menu = gets.chomp.to_i
            case second_menu
              when 1
                @@ttt.start_game(player)
                player = @@ttt.turns
              when 2
                @@ttt.check_winners
              when 3
                break
              else
                puts "Choose a valid element".red
            end
          end
        when 2
          break
        else
          puts "Choose a valid element".red
      end
    end
  end
end

class Main
  include TicTacToeCol
end 
# Main.new.start
