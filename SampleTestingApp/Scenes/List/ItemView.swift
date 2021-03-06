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
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                Text("\(data.name ?? "")")
                    .foregroundColor(.white)
                    .accessibility(identifier: "\(AccessibilityIdentifiers.List.Items.item)\(self.index)")
                Button(action: {
                    self.showingAlert = true
                }) {
                    Text("")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(data.name ?? ""), message: Text(data.model ?? ""), dismissButton: .default(Text("Close")))
                }
            }
            .foregroundColor(.blue)
        }
    }
}
