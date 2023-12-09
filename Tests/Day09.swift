import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day09Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

  func testPart1Example() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "114")
  }

    func testPart1Solution() throws {
      let challenge = Day09()
      XCTAssertEqual(String(describing: challenge.part1()), "1647269739")
    }

  func testPart2Example() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "2")
  }
    
    func testPart2Solution() throws {
      let challenge = Day09()
      XCTAssertEqual(String(describing: challenge.part2()), "864")
    }
}
