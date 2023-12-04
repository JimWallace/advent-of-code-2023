import Algorithms
import Foundation

struct Day04: AdventDay {
        
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var games: [String]
  var matches: [Int] = [Int]()
  var scores: [Int] = [Int]()

    init(data: String) {
        self.data = data
        self.games = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        matches = [Int]()
        scores = [Int]()
        
        for game in games {
            let components = game.components(separatedBy: [":", "|"])
            let name = components[0]
            
            var winners: [Int] = [Int]()
            //var usedWinners: [Int] = [Int]()
            for text in components[1].components(separatedBy: CharacterSet.whitespaces).filter({ !$0.isEmpty }) {
                winners.append( Int(text) ?? -1 )
            }
            
            var draws: [Int] = [Int]()
            var usedDraws: [Int] = [Int]()
            for text in components[2].components(separatedBy: CharacterSet.whitespaces).filter({ !$0.isEmpty }) {
                draws.append( Int(text) ?? -1 )
            }
            
            var hits = 0
            for w in winners {
                for (i,d) in draws.enumerated() {
                    if d == w {
                        hits += 1
                        draws.remove(at: i)
                        usedDraws.append(d)
                    }
                }
            }
            matches.append(hits)
            scores.append(calculateScore(hits))
        }
    }
    
  // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        //    // Calculate the sum of the first set of input data
        //    entities.first?.reduce(0, +) ?? 0
        //var totalScore = 0
                
        return scores.reduce(0, +)
    }

    func calculateScore(_ hits: Int) -> Int {
        if hits < 1 { return 0 }
        
        var cards = hits - 1
        var score = 1
        while cards > 0 {
            score *= 2
            cards -= 1
        }
        return score
    }
    
  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
      var tickets: [UInt64] = Array(repeating: 1, count: scores.count)
      
      for (index, _) in tickets.enumerated().reversed() {
          //tickets[index] = UInt64(scores[index])
          
          var add = matches[index]
          while add > 0 && index + add < scores.count {
              tickets[index] += tickets[index + add]
              add -= 1
          }
      }
            
      return tickets.reduce(0, +)
  }
}
