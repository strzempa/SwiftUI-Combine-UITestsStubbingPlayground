#if canImport(SwiftUI)
import SwiftUI
#endif

struct MainNavigationView: View {
    private var swapiService: SWAPIService!
    
    init(swapiService: SWAPIService) {
        self.swapiService = swapiService
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ListView(swapiService: swapiService)
                    .navigationBarTitle("Main")
            }
        }
    }
}
