require_relative "card.rb"
require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"
class Game
    def initialize(tries = 15, player = "Player 1")
        @board = Board.new
        @tries = tries
        @player = Player.new(player)
    end

    def run
        show_board
        while !@board.win?
            tries_remaining
            guess1 = get_input
            while !valid?(guess1)
                guess1 = get_input
            end
            place(guess1)
            show_board

            guess2 = get_input
            while !valid?(guess2)
                guess2 = get_input
            end
            place(guess2)
            show_board
            pair?(guess1, guess2)

            break if lose?
            break if @board.win?
        end
        puts "Game Over!"
    end

    def get_input
        puts "Enter a valid guess (Ex: 0 0  for first position)"
        guess = gets.chomp.split(" ").map(&:to_i)
    end

    def tries_remaining
        puts "You have #{@tries} tries left"
    end

    def show_board
        @board.display
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

    def pair?(pos1, pos2)
        sleep(2)
        system("clear")
        if !same(pos1, pos2)
            @board.revert(pos1, pos2)
            @board.display
            @tries -= 1
        else
            @board.display
        end
    end

    def lose?
        if @tries == 0
        puts "0 tries left! You Lose!"
        return true
        end
        false
    end
end

Game.new.run