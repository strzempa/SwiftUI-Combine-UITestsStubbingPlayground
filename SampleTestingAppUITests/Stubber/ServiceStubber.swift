import Foundation
import Swifter

final class ServiceStubber {
    private var server = HttpServer()
    private var pushToken: String?
    
    /// The method to set up stubs for test class and start the server.
    /// Needs to be used inside XCTestCase setUp method before XCUIApplication().launch()
    ///
    /// - Parameter stubs: array of prepared network call stubs infos.
    func start(with stubs: [HTTPStubInfo] = []) throws {
        try apply(stubs)
        try server.start()
    }
    
    /// The method to set up stubs for test class and restart the server.
    ///
    /// - Parameter stubs: array of prepared network call stubs infos.
    func restart(with stubs: [HTTPStubInfo]) throws {
        server.stop()
        try start(with: stubs)
    }
    
    /// The method to add new stubs for test class to the existing server.
    ///
    /// - Parameter stubs: array of prepared network call stubs infos.
    func apply(_ stubs: [HTTPStubInfo]) throws {
        for stub in stubs {
            try applyStub(url: stub.url, filename: stub.filename, filetype: stub.filetype, method: stub.method, status: stub.status)
        }
    }
    
    /// The method to stop the server.
    /// Needs to be used inside XCTestCase tearDown method.
    func tearDown() {
        server.stop()
    }
}

private extension ServiceStubber {
    enum Error: Swift.Error {
        case jsonPathFailure(String)
    }
    
    private func applyStub(url: String, filename: String, filetype: HTTPStubInfo.Filetype, method: HTTPStubInfo.HTTPMethod, status: HTTPStubInfo.HTTPStatus) throws {
        let data = try responseData(filename: filename, filetype: filetype)
        let bodyContent = try responseBody(data: data, filetype: filetype)
        
        let requestHandler = makeRequestHandler(bodyContent: bodyContent, status: status)
        switch method {
        case .GET : server.GET[url] = requestHandler
        case .POST: server.POST[url] = requestHandler
        }
    }
}

private extension ServiceStubber {
    func responseBody(data: Data, filetype: HTTPStubInfo.Filetype) throws -> HttpResponseBody {
        switch filetype {
        case .json:
            return .json(try JSONSerialization.jsonObject(with: data) as AnyObject)
        case .html:
            return .html(String(decoding: data, as: UTF8.self))
        }
    }
    
    func makeRequestHandler(bodyContent: HttpResponseBody, status: HTTPStubInfo.HTTPStatus) -> (HttpRequest) -> HttpResponse {
        return { _ in
            switch status {
            case .success:
                return HttpResponse.ok(bodyContent)
            case .notFound:
                return HttpResponse.notFound
            }
        }
    }
    
    func responseData(filename: String, filetype: HTTPStubInfo.Filetype) throws -> Data {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: filename, ofType: filetype.rawValue) else {
            throw Error.jsonPathFailure(filename)
        }
        return try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
    }
}


