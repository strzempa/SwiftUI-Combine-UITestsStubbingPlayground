#if canImport(SwiftUI)
import SwiftUI
#endif

struct ItemView: View {
    private let data: Starships.Result
    private let index: Int
    @State private var showingAlert = false
    
    init?(_ data: Starships.Result?,
          index: Int) {
        guard let data = data else {
            return nil
        }
        self.data = data
        self.index = index
    }
    
    var body: some View {
        VStack {
            Text("\(data.name ?? "")")
                .accessibility(identifier: "\(AccessibilityIdentifiers.List.Items.item)\(self.index)")
            Button(action: {
                self.showingAlert = true
            }) {
                Text("Show")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(data.name ?? ""), message: Text(data.model ?? ""), dismissButton: .default(Text("Close")))
            }
        }
    }
}
