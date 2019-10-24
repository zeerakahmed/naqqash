import XCTest
@testable import Naqqash

final class NaqqashTests: XCTestCase {
    func testIsLetter() {
        XCTAssertEqual(Naqqash.isLetter(Character("a")), false)
        XCTAssertEqual(Naqqash.isLetter(Character("ا")), true)
    }

    func testIsForwardJoining() {
        XCTAssertEqual(Naqqash.isForwardJoining("ا"), false)
        XCTAssertEqual(Naqqash.isForwardJoining("ب"), true)
    }
    
    static var allTests = [
        ("testIsLetter", testIsLetter),
        ("testIsForwardJoining", testIsForwardJoining),
    ]
}
