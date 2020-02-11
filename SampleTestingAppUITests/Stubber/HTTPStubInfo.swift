import Foundation

struct HTTPStubInfo {
    enum HTTPMethod {
        case POST
        case GET
    }
    
    enum HTTPStatus {
        case success
        case notFound
    }
    
    enum Filetype: String {
        case json
        case html
    }
    
    let url: String
    let filename: String
    let method: HTTPMethod
    let status: HTTPStatus
    let filetype: Filetype
}
