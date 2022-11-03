class Deck {
    var cards : Set<Card> = Set<Card>()
    
    init() {
        for value in Value.allCases {
            for colour in Colour.allCases {
                cards.insert(Card(value: value, colour: colour))
            }
        }
    }
    
    func printDeck() {
        for card in cards {
            print(card.getPrintedCard())
        }
    }
    
    static func getRestOfCards(cards: Set<Card>) -> Set<Card> {
        return Deck().cards.subtracting(cards)
    }
}
