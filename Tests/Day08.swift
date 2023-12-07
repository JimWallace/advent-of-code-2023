import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day08Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    """

  func testPart1Example() throws {
    let challenge = Day08(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6000")
  }
    
    func testPart1Solution() throws {
      let challenge = Day08()
      XCTAssertEqual(String(describing: challenge.part1()), "6000")
    }

  func testPart2Example() throws {
    let challenge = Day08(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "32000")
  }
    
    func testPart2Solution() throws {
      let challenge = Day08()
      XCTAssertEqual(String(describing: challenge.part2()), "32000")
    }
}
