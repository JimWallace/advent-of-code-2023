import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day11Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """
    
    let testData2 = """
      #..
      ...
      ..#
      """

    let testData3 = """
      #.
      .#
      """
    
  func testPart1Example() throws {
    let challenge = Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "374")
  }

    func testPart1Example2() throws {
      let challenge = Day11(data: testData2)
      XCTAssertEqual(String(describing: challenge.part1()), "6")
    }
    
    func testPart1Example3() throws {
      let challenge = Day11(data: testData3)
      XCTAssertEqual(String(describing: challenge.part1()), "2")
    }

  func testPart2Example() throws {
    let challenge = Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "1030")
  }
}
