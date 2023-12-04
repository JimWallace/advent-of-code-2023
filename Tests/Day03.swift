import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day03Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    
    func testPart1Example() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "4361")
    }
    
    func testPart1Solution() throws {
        let challenge = Day03()
        XCTAssertEqual(String(describing: challenge.part1()), "544664")
    }
    
    func testPart2Example() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "467835")
    }
    
    func testPart2Solution() throws {
        let challenge = Day03()
        XCTAssertEqual(String(describing: challenge.part2()), "84495585")
    }
}
