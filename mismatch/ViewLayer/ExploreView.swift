import ComposableArchitecture
import NeoBrutalism
import SwiftUI

struct ExploreView: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    let store: StoreOf<Mismatch>

    var body: some View {
        ScrollView {
            LazyVStack(spacing: theme.xlspacing) {
                Spacer()
                    .frame(height: 128) // Initally start below the tab list

                ForEach(store.exploreProfiles) { profileModel in
                    ProfileCardView(store: store, profileModel: profileModel)
                }

                SkeletonProfileCardView()
                    .onAppear {
                        // Whenever skeleton view is present try fetching next profiles
                        store.send(.fetchNextExploreProfiles)
                    }
            }.padding(.horizontal)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreView(store:
        Store(initialState: Mismatch.State()) {
            Mismatch()
        }
    )
}
