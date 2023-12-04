import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day04Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    """

  func testPart1() throws {
    let challenge = Day04(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6000")
  }

  func testPart2() throws {
    let challenge = Day04(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "32000")
  }
}
