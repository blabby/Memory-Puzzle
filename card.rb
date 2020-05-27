class Card
    attr_accessor :value
    def initialize(value)
        @value = value
        @faceup = false
    end

    def toggle
        @faceup = !@faceup
    end
end