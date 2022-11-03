class Game {
    var deck : Deck = Deck()
    var username : String
    var whoHadPersianEyelet : Player? = nil
    
    var isUserActive : Bool = true
    var usersPoints : Int = 0
    var usersHand : String = ""
    var usersCards : Set<Card> = Set<Card>()
    
    var isComputerActive : Bool = true
    var computersPoints : Int = 0
    var computersHand : String = ""
    var computersCards : Set<Card> = Set<Card>()
    
    init(username : String) {
        self.username = username
    }
    
    func drawCardFromDeck(player: Player) {
        let randomCard = deck.cards.randomElement()!
        let printedCard = randomCard.getPrintedCard()
        if player == Player.User {
            if (self.usersHand == "") {
                self.usersHand = printedCard
            } else {
                self.usersHand += ", " + printedCard
            }
            print(self.usersHand, terminator: "")
            
            self.usersPoints += randomCard.getPoints()
            print("  Σ " + String(self.usersPoints))
            self.usersCards.insert(randomCard)
        } else if player == Player.Computer {
            if (self.computersHand == "") {
                self.computersHand = printedCard
            } else {
                self.computersHand += ", " + printedCard
            }
            print(self.computersHand, terminator: "")
            
            self.computersPoints += randomCard.getPoints()
            print("  Σ " + String(self.computersPoints))
            self.computersCards.insert(randomCard)
        }
        deck.cards.remove(randomCard)
    }
    
    func usersMove() {
        self.drawCardFromDeck(player: Player.User)
        print("Dobieram/Pas: ", terminator: "")
        var decision = ""
        repeat {
            decision = readLine() ?? ""
            switch decision {
            case "Dobieram":
                usersMove()
            case "Pas":
                self.isUserActive = false
            default:
                print("Podaj słowo jeszcze raz: ", terminator: "")
            }
        } while decision != "Dobieram" && decision != "Pas"
    }
    
    func computersMove() {
        self.drawCardFromDeck(player: Player.Computer)
        print("Dobieram/Pas: ", terminator: "")
        let decision = self.getComputersDecision()
        print(decision)
        
        switch decision {
        case "Dobieram":
            computersMove()
        case "Pas":
            self.isComputerActive = false
        default:
            print("Podaj słowo jeszcze raz: ", terminator: "")
        }
    }
    
    func getComputersDecision() -> String {
        let restOfPoints = 21 - self.computersPoints
        var numOfFavorableEvents = 0
        var numOfUnfavorableEvents = 0
        
        let restOfCards = Deck.getRestOfCards(cards: self.computersCards)
        
        for card in restOfCards {
            if card.getPoints() <= restOfPoints {
                numOfFavorableEvents += 1
            } else {
                numOfUnfavorableEvents += 1
            }
        }
        
        let oddsOfFavorableEvent = Double(numOfFavorableEvents) / Double(restOfCards.count)
        let oddsOfUnfavorableEvent = Double(numOfUnfavorableEvents) / Double(restOfCards.count)
        
        if (oddsOfFavorableEvent >= oddsOfUnfavorableEvent) {
            return "Dobieram"
        } else {
            return "Pas"
        }
    }
    
    func lookForPersianEyelet() -> Player? {
        var aces = 0
        if self.usersCards.count == 2 {
            for card in self.usersCards {
                if card.value == Value.Ace {
                    aces += 1
                }
            }
        }
        if aces == 2 {
            return Player.User
        }
        
        aces = 0
        if self.computersCards.count == 2 {
            for card in self.computersCards {
                if card.value == Value.Ace {
                    aces += 1
                }
            }
        }
        if aces == 2 {
            return Player.Computer
        }
        return nil
    }
    
    func printSummary() {
        print("---------- PODSUMOWANIE ----------")
        print("Punkty użytkownika " + self.username + ": " + String(self.usersPoints))
        print("Punkty komputera: " + String(self.computersPoints))
    }
    
    func checkWhoWon() -> Player? {
        self.printSummary()
        self.whoHadPersianEyelet = self.lookForPersianEyelet()
        
        if self.whoHadPersianEyelet == Player.User {
            print("Miałeś perskie oczko!")
            return Player.User
        } else if self.whoHadPersianEyelet == Player.Computer {
            print("Komputer miał perskie oczko!")
            return Player.Computer
        }
        
        if self.usersPoints > 21 && self.computersPoints > 21 {
            return nil
        } else if self.usersPoints <= 21 && self.computersPoints > 21 {
            return Player.User
        } else if self.usersPoints > 21 && self.computersPoints <= 21 {
            return Player.Computer
        } else {
            if self.usersPoints > self.computersPoints {
                return Player.User
            } else if self.usersPoints < self.computersPoints {
                return Player.Computer
            } else {
                print("Ty i komputer macie tyle samo punktów!")
                return nil
            }
        }
    }
        
    func play() {
        print("-------------------- OCZKO --------------------")
        print(self.username + ":")
        self.usersMove()
        print("\nKomputer:")
        self.computersMove()
        
        let result = self.checkWhoWon()
        if result == Player.User {
            print("Wygrałeś!")
        } else if result == Player.Computer {
            print("Komputer wygrał!")
        } else {
            print("Nikt nie wygrał!")
        }
    }
}
