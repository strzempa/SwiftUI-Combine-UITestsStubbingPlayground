import XCTest

@discardableResult
public func list(_ defaultQuery: XCUIElement,
                 file: StaticString = #file,
                 line: UInt = #line,
                 closure: (ListRobot) -> Void = { _ in }) -> ListRobot {
    let robot = ListRobot(defaultQuery, file: file, line: line)
    closure(robot)
    return robot
}

final public class ListRobot {
    private let defaultQuery: XCUIElement
    
    init(_ defaultQuery: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        self.defaultQuery = defaultQuery
        XCTAssertTrue(defaultQuery.waitForExistence(timeout: shortTimeout),
                      "default query does not exist",
                      file: file,
                      line: line)
    }
    
    func ifVisibleHeader(equals: Bool, file: StaticString = #file, line: UInt = #line) {
        sleep(1)
        let header = defaultQuery.staticTexts[AccessibilityIdentifiers.List.Labels.header]
        XCTAssertTrue(header.waitForVisible(),
                      "Header is not visible but it should be",
                      file: file,
                      line: line)
        XCTAssertEqual(header.label,
                       "Fetching: false",
                       "Label should equal 'Fetching: false' but it is not")
    }
    
    func ifVisibleTapFetch(file: StaticString = #file, line: UInt = #line) {
        let button = defaultQuery.buttons[AccessibilityIdentifiers.List.Buttons.fetch]
        XCTAssertTrue(button.waitForVisible(),
                      "button is not visible but it should be",
                      file: file,
                      line: line)
        button.tap()
    }
    
    func itemLabel(index: Int, equals text: String, file: StaticString = #file, line: UInt = #line) {
        let tablesQuery = defaultQuery.tables
        let item = tablesQuery.staticTexts["\(AccessibilityIdentifiers.List.Items.item)\(index)"]
        XCTAssertEqual(item.label,
                       text,
                       "Label should equal '\(text)' but it is not")
    }
}
