import Foundation
import Algorithms


struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    var games: [CubeGame] {
        var listOfAllgames: [CubeGame] = [CubeGame]()
        
        for gameText in data.components(separatedBy: CharacterSet.newlines).filter({ !$0.isEmpty }) {
            listOfAllgames.append(CubeGame(from: gameText))
        }
        return listOfAllgames
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        
        var totalPossible: Int = 0
        for i in 0 ..< games.count {
            if games[i].isPossible() {
                totalPossible += i + 1
            }
        }
        return totalPossible
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        
        return games.reduce(0) { (result, game) in
            return result + game.power
        }
        
    }
}
