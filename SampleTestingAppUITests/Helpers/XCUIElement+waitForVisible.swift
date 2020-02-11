import XCTest

public let shortTimeout: TimeInterval = 1
public let defaultTimeout: TimeInterval = 60

public extension XCUIElement {
    func waitForVisible(timeout: TimeInterval = defaultTimeout) -> Bool {
        let predicate = NSPredicate(format: "exists == 1")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
}
