import SwiftUI

struct ContentView: View {
    @State private var columnVisibility =
    NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SoundsView()
                .navigationTitle("Sounds")
            
        } detail: {
            ConfigView()
                .navigationTitle("Configuration")
        }
        .navigationSplitViewStyle(.balanced)
    }
}
