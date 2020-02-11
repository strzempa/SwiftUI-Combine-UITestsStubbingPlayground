#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(Combine)
import Combine
#endif

struct ListView: View {
    private var swapiService: SWAPIService!
    
    @State var tasks: AnyCancellable?
    @State var items: [Any] = [] {
        didSet {
            tasks?.cancel()
            tasks = nil /// just to show that it finished running on the UI
        }
    }
    
    init(swapiService: SWAPIService) {
        self.swapiService = swapiService
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Text(NSLocalizedString("Fetching: \(String(tasks != nil))", comment: ""))
                        .foregroundColor(.black)
                        .padding()
                        .padding(.leading, 60)
                        .padding(.trailing, 60)
                        .accessibility(identifier: AccessibilityIdentifiers.List.Labels.header)
                }
                .padding(.top, 10)
                .fixedSize()
            }
            Button(
                action: { self.fetchData() },
                label: { Text("Fetch data") }
            )
                .accessibility(identifier: AccessibilityIdentifiers.List.Buttons.fetch)
            List(items.indices, id: \.self) { index in
                ZStack {
                    ItemView(self.items[index] as? Starships.Result,
                             index: index)
                }
            }.padding(30)
                .padding()
        }
    }
    
    func fetchData() {
        tasks
            = swapiService
                .fetch(.starships)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [self] data in
                        self.items = data.results ?? []
                })
    }
    
    func cancelTasks() {
        tasks?.cancel()
    }
}
