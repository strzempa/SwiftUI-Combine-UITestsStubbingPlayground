import Foundation
#if canImport(Combine)
import Combine
#endif

struct Service {
    var session: URLSession!
    private let decoder: JSONDecoder = JSONDecoder()
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        print(request)
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                print(String(data: result.data, encoding: .utf8) ?? "")
                let value = try self.decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

extension Service {
    func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return self.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
