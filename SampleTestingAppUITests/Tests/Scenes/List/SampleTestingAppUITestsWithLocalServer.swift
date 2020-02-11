import XCTest

final class SampleTestingAppUITestsWithLocalServer: XCTestCase {
    private var app: XCUIApplication!
    private let stubber = ServiceStubber()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        try! stubber.start(with: [])
        
        app = XCUIApplication()
        app.launch(for: .local)
    }

    override func tearDown() {
        app = nil
        stubber.tearDown()
        
        super.tearDown()
    }
    
    func test_givenListLocalEndoint_whenFetched_thenProperItemsVisible() throws {
        try! stubber.apply(Stubs.starships)
        
        list(app) {
            $0.ifVisibleTapFetch()
            $0.itemLabel(index: 0, equals: "X-wing")
            $0.itemLabel(index: 1, equals: "TIE Advanced x1")
            $0.itemLabel(index: 2, equals: "Slave 1")
            $0.itemLabel(index: 3, equals: "Imperial shuttle")
            $0.itemLabel(index: 4, equals: "EF76 Nebulon-B escort frigate")
        }
    }
}
