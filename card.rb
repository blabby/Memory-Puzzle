class Card
    def initialize(value)
        @value = value
        @faceup = false
    end

    def display
        if @faceup
            value
        end
    end
end