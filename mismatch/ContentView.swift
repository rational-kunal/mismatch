import ComposableArchitecture
import NeoBrutalism
import SwiftUI

struct ContentView: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme
    let store: StoreOf<Mismatch>

    var body: some View {
        WithViewStore(store, observe: \.selectedTab) { viewStore in
            Tabs(selectedTabItem: viewStore.binding(send: Mismatch.Action.tabChanged)) {
                ZStack(alignment: .top) {
                    theme.background.ignoresSafeArea()

                    VStack {
                        TabsContent(tabItem: Mismatch.State.Tab.explore) {
                            ExploreView(store: store)
                        }
                        TabsContent(tabItem: Mismatch.State.Tab.liked) {
                            LikedView(store: store)
                        }
                    }

                    TabsList {
                        TabsTrigger(tabItem: Mismatch.State.Tab.explore) {
                            Text("👀").font(.title)
                        }
                        TabsTrigger(tabItem: Mismatch.State.Tab.liked) {
                            Text("💗").font(.title)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .neoBrutalism(theme: store.state.theme)
    }
}

#Preview {
    ContentView(store: Store(initialState: Mismatch.State()) {
        Mismatch()
    })
}
