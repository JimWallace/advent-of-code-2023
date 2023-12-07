import Algorithms
import Foundation

struct Day05: AdventDay {
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var seeds: [Int] = [Int]()
    var partTwoSeeds: [(Int,Int)] = [(Int, Int)]()
    
    var maps: [map] = [map]()
    var pathway: [map] = [map]()
    
    init(data: String) {
        self.data = data
        seeds = [Int]()
        partTwoSeeds = [(Int,Int)]()
        maps = [map]()
        pathway = [map]()
        
        let lines = data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
        
        for (index,line) in lines.enumerated() {
            
            if line.contains("seeds:") {
                seeds = line.split(separator: ":")[1].components(separatedBy: " ").compactMap { Int($0) }
                //print("Seeds: \(seeds)")
            }
            
            if line.contains("map:") {
                
                // find Types that we are converting between
                let types = line.split(separator: ":")[0].trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "-to-")
                
                var ranges: [SubstituteRange] = [SubstituteRange]()
                var x = index+1
                repeat {
                    //print("X: \(x) -> \(lines[x])")
                    let values = lines[x].components(separatedBy: " ").compactMap { Int($0) }
                    
                    ranges.append( SubstituteRange(destinationStart: values[0], sourceStart: values[1], rangeLength: values[2]))
                    x += 1
                } while  x < lines.count && !lines[x].isEmpty && !lines[x].contains("map:")
                
                maps.append(map(from: String(types[0]), to: String(types[1].split(separator: " ")[0]), ranges: ranges))
                
            }
        }
        
        // Setup partTwoSeeds
        for (i, _) in seeds.enumerated() {
            if i.isMultiple(of: 2) {
                partTwoSeeds.append( (seeds[i], seeds[i+1]) )
            }
        }
        
        // Setup pathway
        var currentState: String = "seed"
        while currentState != "location" {
            for map in maps {
                if map.from == currentState {
                    pathway.append(map)
                    currentState = map.to
                }
            }
        }

        //print("Maps: \(maps)")
    }
        
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        
        var locations: [Int] = [Int]()
        for seed in seeds {
            var current = seed
            for path in pathway {
                current = path.mapSingleValue(current)
            }
            locations.append(current)
        }
                
        return locations.min()!
    }
    
    
      func part2() -> Any {
          
          var locations: [Int] = [Int]()
                    
          for seed in partTwoSeeds {
              
              // Init with one seed range
              var current: [(Int,Int)] = [(Int,Int)]()
              current.append(seed)
              print("Processing: \(seed))")
              
              for path in pathway {
                  
                  var outputs = [(Int,Int)]()
                  
                  // Take each range and push it through each map in the path
                  while !current.isEmpty {
                      print("Start loop")
                      let (start, length) = current.removeFirst()
                      let x = path.mapRange(start, length)
                      print("(\(start),\(length)) -> \(x)")
                      outputs.append(contentsOf: x)
                  }
                  
                  // Move everything along a stage
                  current = outputs
              }
              
              // Put the minimum value for this seed in our list
              if let minValue = current.min(by: { $0.0 < $1.0 }) {
                  locations.append(minValue.0)
                  print("Minimum value based on the first item: \(minValue.0)")
              }
          }
                  
          return locations.min()!
      }
}

struct map {
    let from: String
    let to: String
    let ranges: [SubstituteRange]
    
    func mapSingleValue(_ v: Int) -> Int {
        for range in ranges {
            if v >= range.sourceStart && v < range.sourceStart + range.rangeLength {
                let delta = v - range.sourceStart
                return range.destinationStart + delta
            }
        }
        return v
    }
    
    func mapRange(_ start: Int, _ length: Int) -> [(Int,Int)] {
        
        var result: [(Int,Int)] = [(Int,Int)]()
        var unhandledRanges: [(Int, Int)] = [(start, length)]
                
        while !unhandledRanges.isEmpty {
            
            print("mapRange: \(unhandledRanges)")
            
            // Pop the first one
            var (unhandledStart, unhandledLength) = unhandledRanges.removeFirst()
            var handled = false
            
            
            for range in ranges {
            
                print("-> Range: \(range)")
                
                // Simple case, it's entirely contained in a single range
                // Increment the whole thing, and return - we're done!
                if range.contains(unhandledStart, unhandledLength) {
                    print("Contains> Unhandled: \(unhandledRanges) Result \(result)")
                    let delta = unhandledStart - range.sourceStart
                    result.append((range.destinationStart + delta, unhandledLength))
                    handled = true
                    if unhandledRanges.isEmpty { return result }
                }
                
                // Difficult case, requires one or more splits
                // Divide into 2-3 ranges, process each
                // This is also where we might
                 else if range.overlaps(unhandledStart, unhandledLength) {
                    print("Overlaps> Unhandled: \(unhandledRanges) Result \(result)")
                     
                    // If we overlap to the right, shorten the length
                    if unhandledStart + unhandledLength > range.sourceStart + range.rangeLength {
                        
                        // Everything past the end needs to get handled
                        let l = unhandledStart + unhandledLength - (range.sourceStart + range.rangeLength)
                        unhandledRanges.append((range.sourceStart + range.rangeLength + 1, l))
                                                
                        // Reduce the length of unhandles input
                        unhandledLength = range.sourceStart + range.rangeLength - 1
                    } // TODO: How do we pick this up in another range in this filter?
                    
                    
                    // If we overlap to the left, move the start point
                    if unhandledStart < range.sourceStart {
                        
                        // Map the part that we can handle for now
                        unhandledRanges.append((unhandledStart, range.sourceStart - unhandledStart - 1))
                        
                        // reduce the length of unhandled input
                        let delta = range.sourceStart - unhandledStart
                        unhandledStart += delta
                        unhandledLength -= delta
                    }
                    
                    // Handle whatever was overlapping
                    result.append((range.destinationStart,unhandledLength))
                    
                 }
                // If we don't overlap, loop around and see if another range does
            }
            
            // Didn't hit any range, just pass through
            if handled == false {
                result.append((unhandledStart, unhandledLength))
            }
            
        }
        return result
    }
    
}

struct SubstituteRange {
    let destinationStart: Int
    let sourceStart: Int
    let rangeLength: Int

//    func overlaps(_ r: SubstituteRange) -> Bool {
//        if r.sourceStart + r.rangeLength < sourceStart && r.sourceStart > sourceStart + rangeLength {
//            return false
//        }
//        return true
//    }
    
    func overlaps(_ start: Int, _ length: Int) -> Bool {
        if start + length < sourceStart && start > sourceStart + rangeLength {
            return false
        }
        return true
    }
        
    func contains(_ start: Int, _ length: Int ) -> Bool {
        if start > sourceStart && start + length < sourceStart + rangeLength {
            return true
        }
        return false
    }
}
