class Player
    attr_accessor :name, :memory
    def initialize(name)
        @name = name
        @memory = {}
    end

    def get_input(length)
        puts "Enter a valid guess (Ex: 0 0  for first position)"
        guess = gets.chomp.split(" ").map(&:to_i)
    end

    def store_memory(card, location)
        #duck-typing
    end

    def check_memory(card)
        #duck-typing
    end
end

