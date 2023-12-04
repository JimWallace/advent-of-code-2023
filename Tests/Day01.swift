import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let part1Example = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    let part2Example = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
        
    func testPart1Example() throws {
        let challenge = Day01(data: part1Example)
        XCTAssertEqual(String(describing: challenge.part1()), "142")
    }
    
    func testPart1Solution() throws {
       let challenge = Day01()
       XCTAssertEqual(String(describing: challenge.part1()), "53651")
    }
    
    func testPart2Example() throws {
        let challenge = Day01(data: part2Example)
        XCTAssertEqual(String(describing: challenge.part2()), "281")
    }
    
    func testPart2Solution() throws {
        let challenge = Day01()
        XCTAssertEqual(String(describing: challenge.part2()), "53894")
    }

}
