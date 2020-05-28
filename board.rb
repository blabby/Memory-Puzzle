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
        board = @hidden_board
        position = board.length
        pair1_pos = [rand(position), rand(position)]   
        pair2_pos = [rand(position), rand(position)]   


        while !valid_pos?(pair1_pos)
        pair1_pos = [rand(position), rand(position)]   
        end
        board[pair1_pos.first][pair1_pos.last] = Card.new(letter).value
        while !valid_pos?(pair2_pos)
        pair2_pos = [rand(position), rand(position)]   
        end
        board[pair2_pos.first][pair2_pos.last] = Card.new(letter).value
    end
    end

    
    def guess(pos1, pos2)
        @display_board[pos1.first][pos1.last] = @hidden_board[pos1.first][pos1.last]
        @display_board[pos2.first][pos2.last] = @hidden_board[pos2.first][pos2.last]

        if @hidden_board[pos1.first][pos1.last] !=  @hidden_board[pos2.first][pos2.last]
            revert(pos1, pos2)
        end
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
