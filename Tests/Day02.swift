import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day02Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let part1Example = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    let part2Example = """
    """
        
    func testPart1Example() throws {
        let challenge = Day02(data: part1Example)
        XCTAssertEqual(String(describing: challenge.part1()), "8")
    }
    
    func testPart1Solution() throws {
       let challenge = Day02()
       XCTAssertEqual(String(describing: challenge.part1()), "2528")
    }
    
    func testPart2Example() throws {
        let challenge = Day02(data: part1Example)
        XCTAssertEqual(String(describing: challenge.part2()), "2286")
    }
    
    func testPart2Solution() throws {
        let challenge = Day02()
        XCTAssertEqual(String(describing: challenge.part2()), "67363")
    }

}
