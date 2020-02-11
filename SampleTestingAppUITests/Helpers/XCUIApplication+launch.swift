import XCTest

extension XCUIApplication {
    func launch(for environment: Environment) {
        launchEnvironment = [ProcessInfo.environmentKey: environment.rawValue]
        launch()
    }
}
