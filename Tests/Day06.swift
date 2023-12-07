import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    """

  func testPart1Example() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "288")
  }
    
    func testPart1Solution() throws {
      let challenge = Day06()
      XCTAssertEqual(String(describing: challenge.part1()), "160816")
    }

  func testPart2Example() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "71503")
  }
    
    func testPart2Solution() throws {
      let challenge = Day06()
      XCTAssertEqual(String(describing: challenge.part2()), "46561107")
    }
}
