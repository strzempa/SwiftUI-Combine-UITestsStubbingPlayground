import Foundation

public class EnvironmentProvider {
    func environment(for string: String) -> Environment? {
        return Environment(rawValue: string)
    }

    var currentEnvironment: Environment {
        guard let value = ProcessInfo.processInfo.environment[ProcessInfo.environmentKey] else {
            return .default
        }

        return environment(for: value) ?? .default
    }
}

extension Environment {
    static var `default`: Environment {
        return .prod
    }

    static var current: Environment {
        return EnvironmentProvider().currentEnvironment
    }
}

@objc extension ProcessInfo {
    static let environmentKey = "environment"
}
