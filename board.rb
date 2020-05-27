require_relative "card.rb"
class Board
    attr_accessor :hidden_board, :display_board
    def initialize
        @grid = (:A..:Z).to_a
        @hidden_board = Array.new(4) {Array.new(4, " ")}
        @display_board = Array.new(4) {Array.new(4, " ")}
    end

    def display_board
        puts "    0    1    2    3   "
        @display_board.each_with_index do |value,i| #change this to display_board
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

    #promp user for guess (ex: 0 0  and we will then .split(" "))
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
        true
    end

    #game
    #Enter guess for card 1
    #0 0
    #@hidden_board[0][0]
    #change @display board to equal that value
    #Enter guess for card 2
    #0 2
    #@hidden_board[0][2]
    #if equal to guess1 we will continue on
    #if not equal we set both @display..[0][0] and @display..[0][2] to " "

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


g = Board.new
g.populate
g.guess([0,0],[0,1])
g.display_board
