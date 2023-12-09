import Algorithms
import Foundation

struct Day08: AdventDay {
        
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var lines: [String] {
        data.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }
    }
    var directions: String {
        lines[0]
    }
    
    var classMap: [String : Node ]
    var textMap: [ String: (String,String)]
    
    init(data: String) {
        self.data = data
        self.textMap = [String: (String, String)]()
        self.classMap = [String : Node]()
        
        for (_, line) in lines.dropFirst().enumerated() {
            let components = line.split(separator: "=")
            let source = components[0].replacingOccurrences(of: " ", with: "")
            
            let destinations = components[1].replacingOccurrences(of: " ", with: "").split(separator: ",")
            
            classMap[source] = Node(label: source)
            textMap[source] = ( String(destinations[0].replacingOccurrences(of: "(", with: "")), String(destinations[1].replacingOccurrences(of: ")", with: "")))
        }
        
        // Link left/right nodes
        for (key, value) in classMap {
            value.left = classMap[ textMap[key]!.0 ]
            value.right = classMap[ textMap[key]!.1 ]
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return getStepsFromClassMap("AAA", {$0 == "ZZZ"})
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let startStates = textMap.keys.filter{ $0.hasSuffix("A") }
        //print(startStates)
        
        let loopLengths: [Int] = startStates.map{ let steps = getStepsFromClassMap($0); print("\($0): \(steps)"); return steps  }
        //print(loopLengths)
        
        
        return lcm(loopLengths)        
    }
    
    func getSteps(_ initialState: String, _ finished: (String) -> Bool = {$0.hasSuffix("Z")}) -> Int {
        var currentState = initialState
        var steps = 0
        
        while !finished(currentState) {
            for direction in directions {
                if direction == "L" {
                    currentState = textMap[currentState]!.0
                }
                if direction == "R" {
                    currentState = textMap[currentState]!.1
                }
                steps += 1
            }
        }
        return steps
    }
    
    func getStepsFromClassMap(_ initialState: String, _ finished: (String) -> Bool = {$0.hasSuffix("Z")}) -> Int {
        var currentState = classMap[ initialState ]
        var steps = 0
        
        while !finished(currentState!.label) {
            for direction in directions {
                if direction == "L" {
                    currentState = currentState!.left
                }
                if direction == "R" {
                    currentState = currentState!.right
                }
                steps += 1
            }
        }
        return steps
    }
    
    // GCD of two numbers:
    func gcd(_ a: Int, _ b: Int) -> Int {
        var (a, b) = (a, b)
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }

    // GCD of a vector of numbers:
    func gcd(_ vector: [Int]) -> Int {
        return vector.reduce(0, gcd)
    }

    // LCM of two numbers:
    func lcm(a: Int, b: Int) -> Int {
        return (a / gcd(a, b)) * b
    }

    // LCM of a vector of numbers:
    func lcm(_ vector : [Int]) -> Int {
        return vector.reduce(1, lcm)
    }
}


class Node: CustomStringConvertible {
        
    let label: String
    var left: Node?
    var right: Node?
    
    var description: String { return String("\(label): \(left) <- -> \(right)") }
    
    init(label: String) {
        self.label = label
        left = nil
        right = nil
    }
}


//struct Node: CustomStringConvertible {
//    let label: String
//    var left: UnsafePointer<Node>?
//    var right: UnsafePointer<Node>?
//    
//    var description: String {
//        let l = left?.pointee.label ?? "nil"
//        let r = right?.pointee.label ?? "nil"
//        return "\(label): (\(l), \(r))"
//    }
//}
