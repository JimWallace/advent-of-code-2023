import Algorithms
import Foundation

struct Day06: AdventDay {
        
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

    let times: [Int]
    let distances: [Int]
    
    init(data: String) {
        self.data = data
        let lines = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        times = lines[0].split(separator: ":")[1].components(separatedBy: " ").compactMap { Int($0) }
        distances = lines[1].split(separator: ":")[1].components(separatedBy: " ").compactMap { Int($0) }
    }
    
  

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    print("Times: \(times)\nDistances: \(distances)")
      
      var winningWays: [Int] = Array(repeating: 0, count: times.count)
      
      for race in 0 ..< times.count {
          
          let time = times[race]
          let distance = distances[race]
          
          for i in 1 ..< time {
              if i * (time - i) > distance {
                  winningWays[race] += 1
              }
          }
      }
      
      print("Winning ways: \(winningWays)")
      
      return winningWays.reduce(1, *)
  }

   
    func part2() -> Any {
        var winningWays: Int = 0
        
        let lines = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        let time = Int(lines[0].split(separator: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0
        let distance = Int(lines[1].split(separator: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0
        
        for i in 1 ..< time {
            if i * (time - i) > distance {
                winningWays += 1
            }
        }
        
        print("Winning ways: \(winningWays)")
        
        return winningWays
        
    }
}
