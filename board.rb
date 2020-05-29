require_relative "card.rb"

class Board
    attr_accessor :hidden_board, :display_board
    def initialize
        @grid = (:A..:Z).to_a
        @hidden_board = Array.new(4) {Array.new(4, " ")}
        @display_board = Array.new(4) {Array.new(4, " ")}
        populate 
    end

    def display
        puts "    0    1    2    3   "
        @display_board.each_with_index do |value,i| 
            puts "#{i} #{value}"
        end
    end

    def populate
        while !filled?
            letter = unique_pair
            pos = @hidden_board.length
            #randomize first pair
            pair1_pos = randomize_pos(pos)
            valid_pos1 = randomizer(pair1_pos)
            populate_space(valid_pos1, letter)
            #randomize second pair
            pair2_pos = randomize_pos(pos)
            valid_pos2 = randomizer(pair2_pos)
            populate_space(valid_pos2, letter)
        end
    end

    def randomizer(pos)
        while !valid_pos?(pos)
            pos = randomize_pos(@hidden_board.length)
        end
        return pos if valid_pos?(pos)
    end

    def randomize_pos(pos)
        [rand(pos), rand(pos)]
    end

    def populate_space(pos, letter)
        @hidden_board[pos.first][pos.last] = Card.new(letter).value
    end

    def revert(pos1, pos2)
        @display_board[pos1.first][pos1.last] = " "
        @display_board[pos2.first][pos2.last] = " "
    end

    def win?
        @display_board.each do |array|
            return false if array.any? {|value| value == " "}
        end
        puts "YOU WIN!"
        true
    end

    def valid_pos?(pos)
        return false if @hidden_board[pos.first][pos.last] != " "
        true
    end

    def filled?
        @hidden_board.each do |array|
            return false if array.any? {|value| value == " "}
        end
        true
    end

    def unique_pair
        val = @grid.sample
        @grid.delete(val)
        val
    end

end