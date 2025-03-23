import ComposableArchitecture
import NeoBrutalism
import SwiftUI

struct LikedView: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    let store: StoreOf<Mismatch>

    var body: some View {
        ScrollView {
            LazyVStack(spacing: theme.xlspacing) {
                Spacer()
                    .frame(height: 128) // Initally start below the tab list

                if store.likedProfiles.isEmpty {
                    NoLikesAlertView()
                }

                ForEach(store.likedProfiles) { profileModel in
                    ProfileCardView(store: store, profileModel: profileModel)
                }
            }.padding(.horizontal)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LikedView(store:
        Store(initialState: Mismatch.State()) {
            Mismatch()
        }
    )
}
