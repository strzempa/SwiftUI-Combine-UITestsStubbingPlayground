import Foundation

@objc class EnvironmentApplier: NSObject {
    typealias URLMapping = [Environment: [String: String]]
    let urlMapping: URLMapping

    init(urlMapping: URLMapping) {
        self.urlMapping = urlMapping
        super.init()
    }

    override convenience init() {
        let urlMapping: URLMapping = [.local: ["https://swapi.co/api/": "http://localhost:8080/"]]
        self.init(urlMapping: urlMapping)
    }

    func transform(url: URL, for environment: Environment) -> URL {
        let path = url.absoluteString
        return urlMapping[environment]?
            .first { path.starts(with: $0.key) }
            .map {
                let newPath = path.replacingOccurrences(of: $0.key, with: $0.value)
                return URL(string: newPath) ?? url
        } ?? url
    }

    func transform(request: URLRequest, for environment: Environment) -> URLRequest {
        guard let url = request.url else { return request }
        let newURL = transform(url: url, for: environment)
        guard url != newURL else { return request }
        return request.with(url: newURL)
    }

    @objc func transform(url: URL) -> URL {
        return transform(url: url, for: .current)
    }

    @objc func transform(request: URLRequest) -> URLRequest {
        return transform(request: request, for: .current)
    }
}

extension URLRequest {
    func with(url: URL) -> URLRequest {
        var newRequest = self
        newRequest.url = url
        return newRequest
    }
}
