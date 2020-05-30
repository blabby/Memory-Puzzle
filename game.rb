require_relative "card.rb"
require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"
class Game
    def initialize(tries = 15, player = "Player 1")
        @board = Board.new
        @tries = tries
        @player = Player.new(player) #Change to Computer.new for computer player
    end

    def run
        show_board
        while !@board.win?
            tries_remaining
    
            guess1 = @player.get_input(length)
            while !valid?(guess1)
                guess1 = @player.get_input(length)
            end
            @player.store_memory(place(guess1),guess1)
            show_board

            card = get_card(guess1)

            if remember?(card) && unique?(card, guess1)
                guess2 = @player.check_memory(card)
            else
            guess2 = @player.get_input(length)
            while !valid?(guess2)
                guess2 = @player.get_input(length)
            end
        end
            @player.store_memory(place(guess2), guess2)
            show_board
            pair?(guess1, guess2)

            break if lose?
            break if @board.win?
        end
        puts "Game Over!"
    end

    def unique?(card, location)
        @player.memory[card] != location
    end

    def tries_remaining
        puts "#{@player.name} you have #{@tries} tries left"
    end

    def show_board
        @board.display
    end

    def valid?(pos)
        pos.none? {|pos| pos < 0 || pos > @board.display_board.length - 1}
        @board.display_board[pos.first][pos.last] == " "
    end

    def place(pos)
        @board.display_board[pos.first][pos.last] =  @board.hidden_board[pos.first][pos.last]
        @board.display_board[pos.first][pos.last]
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

    def length
        @board.display_board.length
    end

    def get_card(pos)
        @board.display_board[pos.first][pos.last]
    end

    def remember?(card)
        @player.memory.include?(card)
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
