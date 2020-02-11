import XCTest

final class SampleTestingAppUITestsWithLocalServer: XCTestCase {
    private var app: XCUIApplication!
    private let stubber = ServiceStubber()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        try! stubber.start()
        
        app = XCUIApplication()
        app.launch(for: .local)
    }

    override func tearDown() {
        app = nil
        stubber.tearDown()
        
        super.tearDown()
    }
    
    func test_givenListLocalEndoint_whenFetched_thenProperItemsVisible() throws {
        try stubber.apply(Stubs.starships)
        
        list(app) {
            $0.ifVisibleTapFetch()
            $0.itemLabel(index: 0, equals: "X-wing")
            $0.itemLabel(index: 1, equals: "TIE Advanced x1")
            $0.itemLabel(index: 2, equals: "Slave 1")
            $0.itemLabel(index: 3, equals: "Imperial shuttle")
            $0.itemLabel(index: 4, equals: "EF76 Nebulon-B escort frigate")
        }
    }
    
    func test_givenListLocalEndoint_whenFetched_andItemTapped_thenAlertAppears() throws {
        try stubber.apply(Stubs.starships)
        
        let alertRobot = itemDetailsAlert(app)
        let listRobot = list(app)
                
        list(app) {
            $0.ifVisibleTapFetch()
            $0.tapItem(index: 0)
        }
        alertRobot
            .closeAlert()
        
        listRobot
            .tapItem(index: 1)
        alertRobot
            .closeAlert()
        
        listRobot
            .tapItem(index: 2)
        alertRobot
            .closeAlert()
        
        listRobot
            .tapItem(index: 3)
        alertRobot
            .closeAlert()
        
        listRobot
            .tapItem(index: 4)
        alertRobot
            .closeAlert()
    }
    
    func test_givenListLocalEndoint_whenItemTapped_thenAlertContainsProperTexts() throws {
        try stubber.apply(Stubs.starships)
                
        list(app) {
            $0.ifVisibleTapFetch()
            $0.tapItem(index: 0)
        }
        itemDetailsAlert(app) {
            $0.label(equals: "T-65 X-wing")
            $0.closeAlert()
        }
        list(app)
            .tapItem(index: 1)
        itemDetailsAlert(app) {
            $0.label(equals: "Twin Ion Engine Advanced x1")
            $0.closeAlert()
        }
    }
}
