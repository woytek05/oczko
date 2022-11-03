class Card : Hashable {
    var value : Value
    var colour : Colour
    var points : Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.value == rhs.value && lhs.colour == rhs.colour
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(colour)
    }
    
    init(value: Value, colour: Colour) {
        self.value = value
        self.colour = colour
        self.points = scoring[value] ?? 0
    }
    
    func getPoints() -> Int {
        return self.points
    }
    
    func getPrintedCard() -> String {
        return self.value.rawValue + self.colour.rawValue + " (" + String(self.points) + ")"
    }
}
