require_relative "card.rb"
require_relative "board.rb"
class Game
    def initialize(tries = 1)
        @board = Board.new
        @tries = tries
    end

    def run
        @board.display
        while !@board.win?
        puts "You have #{@tries} tries left"
        puts "Enter first guess (Ex: 0 0  for first position)"
        guess1 = gets.chomp.split(" ").map(&:to_i)
        while !valid?(guess1)
            puts "Please enter guess, corresponding to a 4x4 board (0-3)"
            guess1 = gets.chomp.split(" ").map(&:to_i)
        end

        place(guess1)
        @board.display

        puts "Enter second guess (Ex: 0 1  for second position)"
        guess2 = gets.chomp.split(" ").map(&:to_i)
        while !valid?(guess2)
            puts "Please enter guess, corresponding to a 4x4 board (0-3)"
            guess2 = gets.chomp.split(" ").map(&:to_i)
        end

        place(guess2)
        @board.display

        sleep(2)
        system("clear")
        
        if !same(guess1, guess2)
            @board.revert(guess1, guess2)
            @board.display
            @tries -= 1
        else
            @board.display
        end

        break if lose?
    end
    puts "Game Over!"
    end

    def valid?(pos)
        pos.none? {|pos| pos < 0 || pos > @board.display_board.length - 1}
    end

    def place(pos)
        @board.display_board[pos.first][pos.last] =  @board.hidden_board[pos.first][pos.last]
    end

    def same(pos1, pos2)
        @board.display_board[pos1.first][pos1.last] == @board.display_board[pos2.first][pos2.last]   
    end

    def lose?
        if @tries == 0
        puts "0 tries left!"
        return true
        end
        false
    end
end

Game.new.run