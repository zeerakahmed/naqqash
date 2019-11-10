import XCTest
import Naqqash

final class NaqqashTests: XCTestCase {
    func testIsLetter() {
        XCTAssertEqual(Naqqash.isLetter(Character("a")), false)
        XCTAssertEqual(Naqqash.isLetter(Character("ا")), true)
    }

    func testIsLeftJoining() {
        XCTAssertEqual(Naqqash.isLeftJoining("ا"), false)
        XCTAssertEqual(Naqqash.isLeftJoining("ب"), true)
        XCTAssertEqual(Naqqash.isLeftJoining("ں"), true)
        XCTAssertEqual(Naqqash.isLeftJoining("ی"), true)
        XCTAssertEqual(Naqqash.isLeftJoining("ٮ"), true)
        XCTAssertEqual(Naqqash.isLeftJoining("ڡ"), true)
        XCTAssertEqual(Naqqash.isLeftJoining("ٯ"), true)
    }
    
    func testRemoveDiacritics() {
        XCTAssertEqual(Naqqash.removeDiacritics("اّ"),"ا")
    }
    
    func testAddTatweel() {
        XCTAssertEqual(Naqqash.addTatweelTo("ب", toDisplay: Naqqash.ContextualForm.Medial), "ـبـ")
        "ـںـ"
    }
    
    static var allTests = [
        ("testIsLetter", testIsLetter),
        ("testIsForwardJoining", testIsLeftJoining),
        ("testRemoveDiacritics", testRemoveDiacritics),
    ]
}
