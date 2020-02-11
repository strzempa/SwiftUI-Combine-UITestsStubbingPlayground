import XCTest

@discardableResult
public func itemDetailsAlert(_ defaultQuery: XCUIElement,
                 file: StaticString = #file,
                 line: UInt = #line,
                 closure: (ItemDetailsAlertRobot) -> Void = { _ in }) -> ItemDetailsAlertRobot {
    let robot = ItemDetailsAlertRobot(defaultQuery, file: file, line: line)
    closure(robot)
    return robot
}

final public class ItemDetailsAlertRobot {
    private let defaultQuery: XCUIElement
    
    init(_ defaultQuery: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        self.defaultQuery = defaultQuery
        XCTAssertTrue(defaultQuery.waitForExistence(timeout: shortTimeout),
                      "default query does not exist",
                      file: file,
                      line: line)
    }
    
    func closeAlert(file: StaticString = #file, line: UInt = #line) {
        defaultQuery.alerts.buttons[AccessibilityIdentifiers.Alert.Buttons.close].tap()
    }
    
    func label(equals text: String, file: StaticString = #file, line: UInt = #line) {
        let label = defaultQuery.alerts.otherElements.staticTexts[text].label
        XCTAssertEqual(label,
                       text,
                       "Label should equal '\(text)' but it is not")
    }
}
