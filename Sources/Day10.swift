import Algorithms
import Foundation

struct Day10: AdventDay {
        
    // Save your data in a corresponding text file in the `Data` directory.
    let data: String
    let lines: [String]
    
    var startX: Int = -1
    var startY: Int = -1
    
    //var searchNext: [(Int,Int)]
    //var steps: Int = 0
    
    init(data: String) {
        self.data = data
        self.lines = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        
        //self.searchNext = [(Int, Int)]()
        
        // Add the S point
        for (y, _ ) in lines.enumerated() {
            for (x, _ ) in lines[y].enumerated() {
                if charAt(x, y).rawValue == "S" {
                    startX = x
                    startY = y
                    //searchNext.append( (x,y) )
                }
            }
        }
    }
    
    func printGrid() {
        for y in lines {
            print(y)
        }
    }
    
    func getGrid() -> [[PipeTile]] {
        var result = [[PipeTile]]()
        for (y, _ ) in lines.enumerated() {
            var currentRow: [PipeTile] = [PipeTile]()
            for (x, _ ) in lines[y].enumerated() {
                currentRow.append(  charAt(x,y) )
            }
            result.append(currentRow)
        }
        return result
    }
    
    func printGrid(_ grid: [[PipeTile]]) {
        for y in 0 ..< grid.count {
            var row: String = ""
            for x in 0 ..< grid[y].count {
                row += grid[y][x].rawValue
            }
            print(row)
        }
    }

    
//    @inlinable
//    func charAt(_ x: Int, _ y: Int) -> Character {
//        if x < 0 || y < 0 || y >= lines.count || x >= lines[y].count  {
//            return "."
//        }
//        let row = lines[y]
//        return row[ row.index( row.startIndex, offsetBy: x)]
//    }
    
    @inlinable
    func charAt(_ x: Int, _ y: Int) -> PipeTile {
        if x < 0 || y < 0 || y >= lines.count || x >= lines[y].count  {
            return .ground
        }
        let row = lines[y]
        return PipeTile(rawValue: String(row[ row.index( row.startIndex, offsetBy: x)])) ?? .ground
    }
            
    @inlinable
    func isConnected( _ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) -> Bool {
        
        let start: PipeTile = charAt(x1,y1)
        let end: PipeTile = charAt(x2,y2)
        
        // <----
        if x1 > x2 {
            if start == .start || start == .horizontal || start == .NWbend || start == .SWbend {
                return end == .horizontal || end == .NEbend || end == .SEbend
            }
        }
        
        // ---->
        if x1 < x2 {
            if start == .start || start == .horizontal || start == .NEbend || start == .SEbend {
                return end == .horizontal || end == .NWbend || end == .SWbend
            }
        }
        
        // ^^^^^
        if y1 > y2 {
            if start == .start || start == .vertical || start == .NEbend || start == .NWbend {
                return end == .vertical || end == .SEbend || end == .SWbend
            }
        }
        
        // VVVVVVV
        if y1 < y2 {
            if start == .start || start == .vertical || start == .SEbend || start == .SWbend {
                return end == .vertical || end == .NEbend || end == .NWbend
            }
        }
        
        // Ground, error, etc.
        return false
    }
    
    func bfs(_ x: Int, _ y: Int, _ map: inout [[PipeTile]]) -> [(Int, Int)] {
        var result: [(Int, Int)] = [(Int,Int)]()
        
        // North
        if isConnected(x, y, x, y - 1) && map[y - 1][x] != .explored {
            result.append((x,y-1))
            map[y-1][x] = .explored
        }
        
        // East
        if isConnected(x, y, x + 1, y) && map[y][x + 1] != .explored {
            result.append((x + 1,y))
            map[y][x + 1] = .explored
        }
        
        // South
        if isConnected(x, y, x, y + 1) && map[y + 1][x] != .explored {
            result.append((x,y + 1))
            map[y + 1][x] = .explored
        }
        
        // West
        if isConnected(x, y, x - 1, y) && map[y][x - 1] != .explored {
            result.append((x - 1,y))
            map[y][x - 1] = .explored
        }
        
        return result
    }
    
    
    func fill(_ x: Int, _ y: Int, _ map: inout [[PipeTile]], _ value: PipeTile) {
        var searchNext: [(Int, Int)] = [(Int,Int)]()
        searchNext.append( (x, y) )
                                
        // Find the loop
        while !searchNext.isEmpty {
            let next = searchNext.removeFirst()
            map[next.1][next.0] = value
            let bfs = fillBFS(next.0, next.1, &map)
            //print(bfs)
            searchNext.append(contentsOf: bfs)
        }
    }
    
    func fillBFS(_ x: Int, _ y: Int, _ map: inout [[PipeTile]]) -> [(Int, Int)] {
        
        var result: [(Int, Int)] = [(Int,Int)]()
        
        if !inRange(x,y,map) { return result }
                        
        // North
        if inRange(x,y - 1,map) && map[y - 1][x] == .ground {
            result.append((x,y-1))
        }
        
        // East
        if inRange(x + 1,y,map) && map[y][x + 1] == .ground {
            result.append((x + 1,y))
        }
        
        // South
        if inRange(x,y + 1,map) && map[y + 1][x] == .ground {
            result.append((x,y + 1))
        }
        
        // West
        if inRange(x - 1,y,map) && map[y][x - 1] == .ground {
            result.append((x - 1,y))
        }
        
        return result
    }
    
    func inRange(_ x: Int, _ y: Int, _ map: [[PipeTile]]) -> Bool {
        if x < 0 || y < 0 || y >= map.count || x >= map[y].count {
            return false
        }
        return true
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        
        var searchNext: [(Int, Int)] = [(Int,Int)]()
        searchNext.append( (startX, startY) )
        var steps: Int = 0
        
        var myMap: [[PipeTile]] = getGrid()
                
        // Find the loop
        while !searchNext.isEmpty {
            let next = searchNext.removeFirst()
            let bfs = bfs(next.0, next.1, &myMap)
            searchNext.append(contentsOf: bfs)
            steps += 1
        }
        
        // return
        return Int(ceil(Double(steps)/2.0))
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {

        var searchNext: [(Int, Int)] = [(Int,Int)]()
        searchNext.append( (startX, startY) )
        var steps: Int = 0
        
        var myMap: [[PipeTile]] = getGrid()
                
        // Find the loop
        while !searchNext.isEmpty {
            let next = searchNext.removeFirst()
            let bfs = bfs(next.0, next.1, &myMap)
            searchNext.append(contentsOf: bfs)
            steps += 1
        }
        myMap[startY][startX] = .explored
        printGrid(myMap)
        print("---")
        
        var inside: Bool = false
        for y in 0 ..< myMap.count {
            inside = false
            for x in 0 ..< myMap[y].count {
                let tile = charAt(x,y)
                //let marked = myMap[y][x] == .outside
                if myMap[y][x] == .explored && tile != .horizontal && tile != .ground && tile != .SEbend && tile != .SWbend && tile != .start {
                    inside = !inside
                }
                // If we found some ground fill it in!
                if myMap[y][x] != .explored && myMap[y][x] != .outside && !inside {
                    fill(x,y, &myMap, inside ? .inside : .outside )
                    //printGrid(myMap)
                    //print("---")
                }
                
            }
        }
        printGrid(myMap)
        
        return myMap.flatMap{ $0 }.filter({$0 != PipeTile.explored && $0 != PipeTile.outside }).count
    }
}


enum PipeTile: String, CustomStringConvertible {
                
    case vertical = "|"
    case horizontal = "-"
    case NEbend = "L"
    case NWbend = "J"
    case SWbend = "7"
    case SEbend = "F"
    case ground = "."
    case start = "S"
    case explored = "X"
    case inside = "I"
    case outside = "O"
        
    var description: String { rawValue }
}
