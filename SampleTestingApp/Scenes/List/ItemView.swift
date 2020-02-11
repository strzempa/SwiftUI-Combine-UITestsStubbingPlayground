#if canImport(SwiftUI)
import SwiftUI
#endif

struct ItemView: View {
    private let data: Starships.Result
    private let index: Int
    
    init?(_ data: Starships.Result?,
          index: Int) {
        guard let data = data else {
            return nil
        }
        self.data = data
        self.index = index
    }
    
    var body: some View {
        Text("\(data.name ?? "")")
            .accessibility(identifier: "\(AccessibilityIdentifiers.List.Items.item)\(self.index)")
    }
}
