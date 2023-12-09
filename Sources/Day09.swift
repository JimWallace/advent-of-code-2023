import Algorithms
import Foundation

struct Day09: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var lines: [String] {
        data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
    }
    
    var samples: [[Int]] {
        var s: [[Int]] = [[Int]]()
        for line in lines {
            s.append( line.components(separatedBy: CharacterSet.whitespaces).compactMap{ Int($0) })
        }
        return s
    }
    
    func extrapolate(_ samples: [Int]) -> Int {
        
        if samples.allSatisfy({ $0 == 0 }) {
            return 0
        }
        
        let derivative: [Int] = zip(samples, samples.dropFirst()).map { $1 - $0 }
        return extrapolate(derivative) + samples.last!
    }

    func extrapolateFirst(_ samples: [Int]) -> Int {
        
        print("> \(samples)")
        if samples.allSatisfy({ $0 == 0 }) {
            return 0
        }
        
        let derivative: [Int] = zip(samples, samples.dropFirst()).map { $1 - $0 }
        return samples.first! - extrapolateFirst(derivative)
    }

    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        
        var nextSample: [Int] = [Int]()
        for sample in samples {
            nextSample.append( extrapolate(sample) )
        }
        return nextSample.reduce(0, +)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var nextSample: [Int] = [Int]()
        for sample in samples {
            print(sample)
            nextSample.append( extrapolateFirst(sample) )
        }
        print(nextSample)
        return nextSample.reduce(0, +)
    }
}
