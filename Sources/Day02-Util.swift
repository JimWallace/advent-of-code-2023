//
//  File.swift
//  
//
//  Created by Jim Wallace on 2023-12-02.
//

import Foundation

struct CubeGame: Codable {
    let number: Int
    let rounds: [CubeGameRound]
    
    var power: Int {
        return getPower()
    }
    
    init(from text: String) {
        let components = text.split(separator: ":", maxSplits: 1)
        
        number = Int(components[0].filter{ $0.isNumber }) ?? 0
        
        var rounds = [CubeGameRound]()
        for round in components[1].components(separatedBy: ";") {
            rounds.append( CubeGameRound(from: round))
        }
        self.rounds = rounds
    }
    
    // Were all the draws possible?
    @inlinable
    func isPossible(maxRed: Int = 12, maxGreen: Int = 13, maxBlue: Int = 14) -> Bool {
        for round in rounds {
            if !round.isPossible() {
                return false
            }
        }
        return true
    }
    
    // What's the *power* of this game?
    @inlinable
    func getPower() -> Int {
        
        var minRed = 0
        var minGreen = 0
        var minBlue = 0
        
        for round in rounds {
            if round.red > minRed {
                minRed = round.red
            }
            if round.green > minGreen {
                minGreen = round.green
            }
            if round.blue > minBlue {
                minBlue = round.blue
            }
        }
        
        return minRed * minGreen * minBlue
    }
}



struct CubeGameRound: Codable {
    let red: Int
    let green: Int
    let blue: Int
    
    init(red: Int = 0, green: Int = 0, blue: Int = 0) {
            self.red = red
            self.green = green
            self.blue = blue
    }
    
    init(from text: String) {
        
        let components = text.components(separatedBy: ",")
        
        var red: Int = 0
        var green: Int = 0
        var blue: Int = 0
        
        for component in components {
            if component.contains("red") {
                red = Int(component.filter{ $0.isNumber }) ?? 0
            }
            if component.contains("blue") {
                blue = Int(component.filter{ $0.isNumber }) ?? 0
            }
            if component.contains("green") {
                green = Int(component.filter{ $0.isNumber }) ?? 0
            }
        }
        
        self.init(red: red, green: green, blue: blue)
        //print("\(text) --> \(self)")
    }
  
    func isPossible(maxRed: Int = 12, maxGreen: Int = 13, maxBlue: Int = 14) -> Bool {
        return red <= maxRed && blue <= maxBlue && green <= maxGreen
    }
    
}
