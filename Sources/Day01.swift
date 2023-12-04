import Foundation
import Algorithms

struct Day01: AdventDay {
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    var lines: [String] {
        data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        
        var sum: Int = 0
                        
        for line in lines {
            
            let digits = line.compactMap { $0.wholeNumberValue }
            
            let firstDigit = digits.first ?? 0
            let lastDigit = digits.last ?? 0
            
            let calibrationValue = firstDigit * 10 + lastDigit
            
            sum += calibrationValue
            print("\(line) -> \(digits) -> \(firstDigit)\(lastDigit) | \(sum) ")
            
        }
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var sum: Int = 0
        
        let replacementsDictionary = ["one": "o1e", "two": "t2o", "three": "t3e", "four": "f4r", "five": "f5e", "six": "s6x", "seven": "s7n", "eight": "e8t", "nine": "n9e"]

        for line in lines {
            
            var textToSearch = line
            
            for (key, value) in replacementsDictionary {
                textToSearch = textToSearch.replacingOccurrences(of: key, with: value)
            }
            
            let digits = textToSearch.compactMap { $0.wholeNumberValue }
            
            let firstDigit = digits.first ?? 0
            let lastDigit = digits.last ?? 0
            
            let calibrationValue = firstDigit * 10 + lastDigit
            
            sum += calibrationValue
            print("\(line) -> \(textToSearch) -> \(digits) -> \(firstDigit)\(lastDigit) | \(sum) ")
        }
     
        return sum
    }
}

