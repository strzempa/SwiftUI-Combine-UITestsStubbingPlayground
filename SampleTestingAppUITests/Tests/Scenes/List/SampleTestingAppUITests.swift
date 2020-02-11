import XCTest

final class SampleTestingAppUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
                
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        
        super.tearDown()
    }

    func test_givenList_whenFetched_thenProperItemsVisible() {
        list(app) {
            $0.ifVisibleTapFetch()
            $0.itemLabel(index: 0, equals: "Executor")
            $0.itemLabel(index: 1, equals: "Sentinel-class landing craft")
            $0.itemLabel(index: 2, equals: "Death Star")
            $0.itemLabel(index: 3, equals: "Millennium Falcon")
            $0.itemLabel(index: 4, equals: "Y-wing")
        }
    }
}
