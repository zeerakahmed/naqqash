import XCTest
import Naqqash

final class NaqqashTests: XCTestCase {
    func testIsLetter() {
        XCTAssertEqual(Naqqash.isLetter(Character("a")), false)
        XCTAssertEqual(Naqqash.isLetter(Character("ا")), true)
    }

    func testIsForwardJoining() {
        XCTAssertEqual(Naqqash.isLeftJoining("ا"), false)
        XCTAssertEqual(Naqqash.isLeftJoining("ب"), true)
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
        ("testIsForwardJoining", testIsForwardJoining),
        ("testRemoveDiacritics", testRemoveDiacritics),
    ]
}
