//
//  ProfileCardView.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftUI

let BG_COLOR = Color(red: 255 / 255, green: 113 / 255, blue: 88 / 255)
let FG_COLOR = Color(red: 199 / 235, green: 208 / 255, blue: 218 / 255)
let WARM_COLOR = Color(red: 253 / 255, green: 43 / 255, blue: 123 / 255)
let MEH_COLOR = Color(red: 66 / 235, green: 66 / 255, blue: 66 / 255)

struct ProfileCardView: View {
    let profileModel: ProfileModel

    var likeButton: some View {
        ProfileCardButtonView(text: "👍", selected: profileModel.liked, backgroundColor: WARM_COLOR) {
            ProfileDataService.shared.likeProfile(profileModel)
        }
    }

    var shortlistButton: some View {
        ProfileCardButtonView(text: "🫤", selected: profileModel.shortlisted, backgroundColor: MEH_COLOR) {
            ProfileDataService.shared.shortlistProfile(profileModel)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            ProfileCardImageView(imageURLString: profileModel.profileImageURLString)
                .cornerRadius(SpacingConstants.large)

            VStack(alignment: .leading) {
                Text(profileModel.displayName)
                    .font(.title)
                    .foregroundStyle(FG_COLOR)
                    .fontWeight(.semibold)

                Text("\(Image(systemName: "mappin")) \(profileModel.displayLocation)")
                    .font(.title2)
                    .foregroundStyle(FG_COLOR)

                HStack(spacing: SpacingConstants.medium) {
                        likeButton
                        shortlistButton
                }
            }
        }
        .padding()
        .background(BG_COLOR)
        .cornerRadius(SpacingConstants.large)
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
    ProfileCardView(profileModel: profileModel)
}
