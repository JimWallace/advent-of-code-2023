import Algorithms
import Foundation

struct Day05: AdventDay {
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var seeds: [Int] = [Int]()
    var partTwoSeeds: [Int] = [Int]()
    var maps: [map] = [map]()

    var pathway: [map] = [map]()
    
    init(data: String) {
        self.data = data
        seeds = [Int]()
        partTwoSeeds = [Int]()
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
        for (i,seed) in seeds.enumerated() {
            if i.isMultiple(of: 2) {
                for newSeed in seed ... seed + seeds[i+1] {
                    partTwoSeeds.append(newSeed)
                }
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
          print("Locations: \(partTwoSeeds.count)")
          var locations: [Int] = [Int]()
          for seed in partTwoSeeds {
              var current = seed
              for path in pathway {
                  current = path.mapSingleValue(current)
              }
              locations.append(current)
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
    
    func overlaps(start: Int, length: Int) -> Bool {
        return false
    }
    
}

struct SubstituteRange {
    let destinationStart: Int
    let sourceStart: Int
    let rangeLength: Int

}
