class Computer
    attr_accessor :name, :memory
    def initialize(name = "Computer 1")
        @name = name
        @memory = {}
    end

    def get_input(length)
        [rand(length), rand(length)]
    end

    def store_memory(card, location)
        if !check_memory(card)
        @memory[card] = location
        end
        false
    end

    def check_memory(card)
        if @memory.include?(card)
            return @memory[card]
        end
        false
    end
end