import Foundation

protocol ServiceFactory {
    static func makeSWAPIService() -> SWAPIService
}

final class DefaultServiceFactory {
    private init() {}
    
    static func makeSWAPIService() -> SWAPIService {
        var swapiService = DefaultSWAPIService()
        var service = Service()
        service.session = URLSession.shared
        swapiService.service = service
        return swapiService
    }
}
