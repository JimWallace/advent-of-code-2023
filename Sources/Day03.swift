import Foundation
import Algorithms
import CoreGraphics

struct Day03: AdventDay {
    
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // My additional stuff for this problem
    var grid: [String]
    //var characterGrid: [[Character]]
    var pointsOfInterest: [PointOfInterest] = []
    var partNumbers: [PartNumber] = []
    
    init(data: String) {
        self.data = data
        self.grid = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
//        self.characterGrid = grid.map { string in
//            Array(string.utf16).compactMap { UnicodeScalar($0) }.map { Character($0) }
//        }
        
        for y in 0 ..< grid.count {
            var x = 0
            while x < grid[y].count {
                switch charAt(x,y) {
                case ".":
                    x += 1          // If empty space, just skip it
                case "0"..."9":     // If a number, record a part number
                    let location = CGPoint(x: x, y: y)
                    var length = 1
                    var value = Int(String(charAt(x, y)))!
                    x += 1
                    while charAt(x,y).isNumber {
                        value = value * 10 + Int(String(charAt(x, y)))!
                        x += 1
                        length += 1
                    }
                    partNumbers.append( PartNumber(value: value, location: location, length: length))
                default:            // If it's anything else, consider it a symbol
                    pointsOfInterest.append( PointOfInterest(value: charAt(x,y),location: CGPoint(x: x,y: y)))
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
    
//    func printGrid() {
//        for y in 0 ..< grid.count {
//            var line: String = ""
//            for x in 0 ..< grid[y].count {
//                line += String(charAt(x,y))
//            }
//            print(line)
//        }
//    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
                    
        var sum: Int = 0
        for part in partNumbers {
            for point in pointsOfInterest {
                if part.adjacent(to: point) {
                    sum += part.value
                }
            }
        }
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        
        let updatedPoints: [PointOfInterest] = pointsOfInterest.map { var point = $0; point.updateAdjacent(parts: partNumbers); return point }
        
        var totalGearRatio: Int = 0
        for point in updatedPoints {
            if point.isGear {
                totalGearRatio += point.gearRatio
            }
        }
        return totalGearRatio
    }
}

struct PartNumber {
    let value: Int
    let location: CGPoint
    let length: Int
    var counted: Bool = false
    
    func adjacent(to: PointOfInterest) -> Bool {
        if minDistance(to: to) < 2 {
            return true
        }
        return false
    }
    
    func minDistance(to: PointOfInterest) -> Double {
        // Just return the minimum distance for any point within the number
        var min = Double.infinity
        for x in 0 ..< self.length {
            let dX = location.x - to.location.x + CGFloat(x)
            let dY = location.y - to.location.y
            let d = sqrt( dX * dX + dY * dY )
            if d < min { min = d }
        }
        return min
    }
}

struct PointOfInterest {
    let value: Character
    let location: CGPoint
    
    var isGear: Bool { return value == "*" && numAdjacent == 2}
    
    var numAdjacent = 0
    var gearRatio: Int = 1
    
    mutating func updateAdjacent(parts: [PartNumber]) {
        for part in parts {
            if part.minDistance(to: self) < 2 {
                numAdjacent += 1
                gearRatio *= part.value
            }
        }
    }
}
