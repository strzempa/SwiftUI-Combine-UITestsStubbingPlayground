import Foundation
#if canImport(Combine)
import Combine
#endif

enum SWAPIEndpoint: String {
    case starships
}

protocol SWAPIService {
    var service: Service! { get set }
    func fetch(_ endpoint: SWAPIEndpoint) -> AnyPublisher<Starships, Error>
}

struct DefaultSWAPIService: SWAPIService {
    var service: Service!
    static let base = URL(string: "https://swapi.co/api")!
}

extension DefaultSWAPIService {
    func fetch(_ endpoint: SWAPIEndpoint) -> AnyPublisher<Starships, Error> {
        var request = URLRequest(url: DefaultSWAPIService.self.base.appendingPathComponent(endpoint.rawValue))
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return service.run(request)
    }
}
