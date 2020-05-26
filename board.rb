require_relative "card.rb"
class Board
    def initialize
        @grid = (:A..:Z).to_a
        @hidden_board = Array.new(4) {Array.new(4, " ")}
        @display_board = Array.new(4) {Array.new(4, " ")}
    end

    def display_board
        puts "    0    1    2    3   "
        @hidden_board.each_with_index do |value,i|
            puts "#{i} #{value}"
        end
    end

    def shuffle_cards
        letter = @grid.sample
        Card.new(letter)
        Card.new(letter)
        #grid.sample  then take this and put 2 of these inside the array randomly
    end

end

    
Board.new.display_board