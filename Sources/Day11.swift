import Algorithms
import Foundation

struct Day11: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    //var lines: [String]
    
    // My additional stuff for this problem
    var grid: [String]
    //var characterGrid: [[Character]]
    var pointsOfInterest: [StarLocation] = []
    var rows: [Bool]
    var cols: [Bool]
    //var partNumbers: [PartNumber] = []
    
    init(data: String) {
        //print("init")
        self.data = data
        //self.lines = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        self.grid = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        self.rows = Array(repeating: false, count: grid[0].count)
        self.cols = Array(repeating: false, count: grid[0].count)
        
        for y in 0 ..< grid.count {
            //print(y)
            var x = 0
            while x < grid[y].count {
                //print(x)
                switch charAt(x,y) {
                
                // If empty space, just skip it
                case ".":
                    x += 1
                
                // If it's a '#' we have a star
                case "#":
                    pointsOfInterest.append( StarLocation(value: "#",location: CGPoint(x: x,y: y)))
                    rows[x] = true
                    cols[y] = true
                    x += 1
                    
                // Anything else, just skip
                default:
                    x += 1
                }
                
            }
        }
    }
        
    
        @inlinable
        func charAt(_ x: Int, _ y: Int) -> Character {
            if x < 0 || y < 0 || y >= grid.count || x >= grid[y].count  {
                return "."
            }
            let row = grid[y]
            return row[ row.index( row.startIndex, offsetBy: x)]
        }

        
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        print("Stars: \(pointsOfInterest)")
        
        var starPairs: [(StarLocation, StarLocation)] =  [(StarLocation, StarLocation)]()
        for i in 0 ..< pointsOfInterest.count {
            for j in i + 1 ..< pointsOfInterest.count {
                starPairs.append( (pointsOfInterest[i], pointsOfInterest[j]))
            }
        }
        
        print("Found \(starPairs.count) pairs.")
        
        var sum: UInt = 0
        for pair in starPairs {
            
            let star1 = pair.0
            let star2 = pair.1
            
            let minX = Int(min(star1.location.x, star2.location.x))
            let maxX = Int(max(star1.location.x, star2.location.x))
            
            let minY = Int(min(star1.location.y, star2.location.y))
            let maxY = Int(max(star1.location.y, star2.location.y))
            
            let extraX: UInt = UInt(rows[minX ..< maxX].filter{ $0 == false }.count)
            let extraY: UInt = UInt(cols[minY ..< maxY].filter{ $0 == false }.count)
            
            let dX: UInt = (maxX - minX).magnitude
            let dY: UInt  = (maxY - minY).magnitude
            
            let distance: UInt = dX + dY + extraX + extraY
            print("Pair: \(pair) | \(dX) + \(dY) + \(extraX) + \(extraY) -> Distance: \(distance)")
            sum += distance
        }
        
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        print("Stars: \(pointsOfInterest)")
        
        var starPairs: [(StarLocation, StarLocation)] =  [(StarLocation, StarLocation)]()
        for i in 0 ..< pointsOfInterest.count {
            for j in i + 1 ..< pointsOfInterest.count {
                starPairs.append( (pointsOfInterest[i], pointsOfInterest[j]))
            }
        }
        
        print("Found \(starPairs.count) pairs.")
        
        var sum: UInt = 0
        for pair in starPairs {
            
            let star1 = pair.0
            let star2 = pair.1
            
            let minX = Int(min(star1.location.x, star2.location.x))
            let maxX = Int(max(star1.location.x, star2.location.x))
            
            let minY = Int(min(star1.location.y, star2.location.y))
            let maxY = Int(max(star1.location.y, star2.location.y))
            
            let extraX: UInt = UInt(rows[minX ..< maxX].filter{ $0 == false }.count) * 999999
            let extraY: UInt = UInt(cols[minY ..< maxY].filter{ $0 == false }.count) * 999999
            
            let dX: UInt = (maxX - minX).magnitude
            let dY: UInt  = (maxY - minY).magnitude
            
            let distance: UInt = dX + dY + extraX + extraY
            print("Pair: \(pair) | \(dX) + \(dY) + \(extraX) + \(extraY) -> Distance: \(distance)")
            sum += distance
        }
        
        return sum    }
}

struct StarLocation: Hashable, CustomStringConvertible {
    let value: Character
    let location: CGPoint
    
    var description: String { return "X: \(location.x) Y: \(location.y)" }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.x)
        hasher.combine(location.y)
    }
}
