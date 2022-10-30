class Card : HashableClass {
    var value : Value
    var colour : Colour
    var points : Int
    
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
