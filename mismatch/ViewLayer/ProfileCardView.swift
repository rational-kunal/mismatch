import ComposableArchitecture
import NeoBrutalism
import SwiftUI

struct ProfileCardView: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    let store: StoreOf<Mismatch>

    let profileModel: ProfileModel
    @State private var isImageLoaded = false

    var likeButton: some View {
        Button(type: .neutral) {
            Text("👍")
                .font(.title2)
                .frame(maxWidth: .infinity)
        } action: {
            store.send(.likeProfile(profileModel))
        }
    }

    var dislikeButton: some View {
        Button {
            Text("❌")
                .font(.title2)
                .frame(maxWidth: .infinity)
        } action: {
            store.send(.dislikeProfile(profileModel))
        }
    }

    var body: some View {
        Card {
            ProfileCardImageView(imageUrlString: profileModel.profileImageURLString)

            VStack(alignment: .leading, spacing: 0) {
                Text(profileModel.displayName)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(profileModel.displayLocation)
                    .font(.title3)
            }

        } footer: {
            HStack(spacing: theme.spacing) {
                dislikeButton

                if profileModel.shouldShowLikeButton {
                    likeButton
                }
            }
        }
    }
}

#Preview {
    let profileModel = ProfileModel(
        id: "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
        firstName: "Jennie",
        lastName: "Nichols",
        streetNumber: "8929",
        streetName: "Valwood Pkwy",
        city: "Billings",
        age: "30",
        profileImageURLString: "https://randomuser.me/api/portraits/men/75.jpg"
    )
    ProfileCardView(store: Store(initialState: Mismatch.State()) {
        Mismatch()
    }, profileModel: profileModel)
}
