import Algorithms
import Foundation

struct Day07: AdventDay {
        
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  var lines: [String] {
        data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
  }
  
    var hands: [(CamelCardHand, Int)]
    var wildHands: [(WildCamelCardHand, Int)]
    //var bids: [Int]
  
    init(data: String) {
        self.data = data
        hands = [ (CamelCardHand, Int)]()
        wildHands = [ (WildCamelCardHand, Int)]()
        //bids = [Int]()
        
        for line in lines {
            let splitLine = line.split(separator: " ")
            //bids.append( Int(splitLine[1]) ?? -1 )
            
            var cards: [CamelCard] = [CamelCard]()
            var wildCards: [WildCamelCard] = [WildCamelCard]()
            for character in String(splitLine[0]) {
                cards.append( CamelCard(rawValue: character) ?? .two ) // TODO: Is a default value of two a problem ... probably?
                wildCards.append( WildCamelCard(rawValue: character) ?? .two)
            }
            let type = CamelCardHandType(cards: cards) ?? .highCard
            let hand = (CamelCardHand(type: type, cards: cards), Int(splitLine[1]) ?? -1)
            hands.append( hand )
            
            let wildType = WildCamelCardHandType(cards: wildCards) ?? .highCard
            let wildHand = (WildCamelCardHand(type: wildType, cards: wildCards), Int(splitLine[1]) ?? -1)
            wildHands.append(wildHand)
            //print(hand)
        }
    }
    
    
  // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
                                
        var score: Int = 0
        for (i, hand) in hands.sorted(by: { $0.0 > $1.0 }).enumerated() {
            print("\(i): \(hand.0)")
            score += (i + 1) * hand.1 // Rank * Bid
        }
        return score
    }

  // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var score: Int = 0
        for (i, hand) in wildHands.sorted(by: { $0.0 > $1.0 }).enumerated() {
            print("\(i): \(hand.0)")
            score += (i + 1) * hand.1 // Rank * Bid
        }
        return score
    }
}

struct CamelCardHand: Comparable, CustomStringConvertible {
    let type: CamelCardHandType
    let cards: [CamelCard]
        
    static func < (lhs: CamelCardHand, rhs: CamelCardHand) -> Bool {
        if lhs.type == rhs.type {
            var i = 0
            while i < lhs.cards.count && i < rhs.cards.count {
                if lhs.cards[i] != rhs.cards[i] {
                    return lhs.cards[i] < rhs.cards[i]
                }
                i += 1
            }
        }
        return lhs.type < rhs.type
    }
    
    var description: String {
        return "\(type) | \(cards)"
    }
}

struct WildCamelCardHand: Comparable, CustomStringConvertible {
    let type: WildCamelCardHandType
    let cards: [WildCamelCard]
        
    static func < (lhs: WildCamelCardHand, rhs: WildCamelCardHand) -> Bool {
        if lhs.type == rhs.type {
            var i = 0
            while i < lhs.cards.count && i < rhs.cards.count {
                if lhs.cards[i] != rhs.cards[i] {
                    return lhs.cards[i] < rhs.cards[i]
                }
                i += 1
            }
        }
        return lhs.type < rhs.type
    }
    
    var description: String {
        return "\(type) | \(cards)"
    }
}

enum CamelCard: String, Comparable, CustomStringConvertible {
    case ace = "A"
    case king = "K"
    case queen = "Q"
    case jack = "J"
    case ten = "T"
    case nine = "9"
    case eight = "8"
    case seven = "7"
    case six = "6"
    case five = "5"
    case four = "4"
    case three = "3"
    case two = "2"
    
    // Implement Comparable protocol
    static func < (lhs: CamelCard, rhs: CamelCard) -> Bool {
        // Define the sorting order based on the raw values
        let order: [CamelCard] = [.ace, .king, .queen, .jack, .ten, .nine, .eight, .seven, .six, .five, .four, .three, .two]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
        
    // Custom initializer to create a PlayingCard from a raw value (Character)
    init?(rawValue: Character) {
        let stringValue = String(rawValue)
        guard let card = CamelCard(rawValue: stringValue) else {
            return nil
        }
        self = card
    }
    
    var description: String {
        return rawValue
    }
}

enum WildCamelCard: String, Comparable, CustomStringConvertible {
    case ace = "A"
    case king = "K"
    case queen = "Q"
    case ten = "T"
    case nine = "9"
    case eight = "8"
    case seven = "7"
    case six = "6"
    case five = "5"
    case four = "4"
    case three = "3"
    case two = "2"
    case jack = "J"
    
    // Implement Comparable protocol
    static func < (lhs: WildCamelCard, rhs: WildCamelCard) -> Bool {
        // Define the sorting order based on the raw values
        let order: [WildCamelCard] = [.ace, .king, .queen, .ten, .nine, .eight, .seven, .six, .five, .four, .three, .two, .jack]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
        
    // Custom initializer to create a PlayingCard from a raw value (Character)
    init?(rawValue: Character) {
        let stringValue = String(rawValue)
        guard let card = WildCamelCard(rawValue: stringValue) else {
            return nil
        }
        self = card
    }
    
    var description: String {
        return rawValue
    }
}


enum CamelCardHandType: String, Comparable, CustomStringConvertible {
    case fiveOfAKind = "Five of a Kind"
    case fourOfAKind = "Four of a Kind"
    case fullHouse = "Full House "
    case threeOfAKind = "Three of a Kind"
    case twoPair = "Two Pair"
    case onePair = "One Pair"
    case highCard = "High Card"
    
    // Implement Comparable protocol
    static func < (lhs: CamelCardHandType, rhs: CamelCardHandType) -> Bool {
        // Define the sorting order based on the raw values
        let order: [CamelCardHandType] = [.fiveOfAKind, .fourOfAKind, .fullHouse, .threeOfAKind, .twoPair, .onePair, .highCard]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
    
    init?(cards: [CamelCard]) {
        guard cards.count == 5 else {
            // A camel card hand should have exactly 5 cards
            return nil
        }
        
        let cardsAsASet = Set<CamelCard>(cards)
        if cardsAsASet.count == 1 {
            self = .fiveOfAKind
            return
        }
        
        if cardsAsASet.count == 2 {
            // .fullHouse
            if cardsAsASet.contains(where: { card in cards.filter { $0 == card }.count == 3 }) {
                self = .fullHouse
                return
            }
            // .fourOfAKind
            self = .fourOfAKind
            return
        }
        
        if cardsAsASet.count == 3 {
            // .threeOfAKind
            if cardsAsASet.contains(where: { card in cards.filter { $0 == card }.count == 3 }) {
                self = .threeOfAKind
                return
            }
            self = .twoPair
            return
            // .twoPair
        }
        
        if cardsAsASet.count == 4 {
            self = .onePair
            return
        }
        
        // Default .. nothing else matched
        self = .highCard
    }
    
    var description: String {
        return rawValue
    }
}

enum WildCamelCardHandType: String, Comparable, CustomStringConvertible {
    case fiveOfAKind = "Five of a Kind"
    case fourOfAKind = "Four of a Kind"
    case fullHouse = "Full House "
    case threeOfAKind = "Three of a Kind"
    case twoPair = "Two Pair"
    case onePair = "One Pair"
    case highCard = "High Card"
    
    // Implement Comparable protocol
    static func < (lhs: WildCamelCardHandType, rhs: WildCamelCardHandType) -> Bool {
        // Define the sorting order based on the raw values
        let order: [WildCamelCardHandType] = [.fiveOfAKind, .fourOfAKind, .fullHouse, .threeOfAKind, .twoPair, .onePair, .highCard]
        return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
    
    init?(cards: [WildCamelCard]) {
        guard cards.count == 5 else {
            // A camel card hand should have exactly 5 cards
            return nil
        }
        
        let cardsAsASet = Set<WildCamelCard>(cards)
        if cardsAsASet.count == 1 {
            self = .fiveOfAKind
            return
        }
        
        if cardsAsASet.count == 2 {
            if cardsAsASet.contains(.jack) {
                self = .fiveOfAKind
                return
            }
            
            // .fullHouse
            if cardsAsASet.contains(where: { card in cards.filter { $0 == card }.count == 3 }) {
                self = .fullHouse
                return
            }
            // .fourOfAKind
            self = .fourOfAKind
            return
        }
        
        if cardsAsASet.count == 3 {
            // .threeOfAKind
            if cardsAsASet.contains(where: { card in cards.filter { $0 == card }.count == 3 }) {
                if cardsAsASet.contains(.jack) {
                    self = .fourOfAKind
                    return
                }
                self = .threeOfAKind
                return
            }
            // Hard case
            let numJacks = cards.filter { $0 == .jack }.count
            if numJacks == 1 {
                self = .fullHouse
                return
            } else if numJacks == 2 {
                self = .fourOfAKind
                return
            } else {
                self = .twoPair
                return
            }
            // .twoPair
        }
        
        if cardsAsASet.count == 4 {
            if cardsAsASet.contains(.jack) {
                self = .threeOfAKind
                return
            }
            self = .onePair
            return
        }
        
        // Default .. nothing else matched
        if cardsAsASet.contains(.jack) {
            self = .onePair
            return
        }
        self = .highCard
    }
    
    var description: String {
        return rawValue
    }
}


