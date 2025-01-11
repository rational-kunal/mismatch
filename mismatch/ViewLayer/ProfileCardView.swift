//
//  ProfileCardView.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

struct ProfileCardView: View {
    let profileModel: ProfileModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .leading) {
                WebImage(url: URL(string: profileModel.profileImageURLString)) { image in
                    image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
            }
            .contentShape(Rectangle())
            .cornerRadius(SpacingConstants.large)

            VStack(alignment: .leading) {
                Text(profileModel.displayTitle)
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                Text(profileModel.displaySubtitle)
                    .font(.title)
                    .foregroundStyle(.white)

                HStack {
                    Button(action: {}) {
                        Text("🙆")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    }

                    Button(action: {}) {
                        Text("🙅")
                            .font(.callout)
                            .foregroundStyle(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue).stroke(.black, style: .init(lineWidth: 1)))
                    }
                }
            }
            .padding(SpacingConstants.large)
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
        profileImageURLString: "https://randomuser.me/api/portraits/men/75.jpg"
    )
    ProfileCardView(profileModel: profileModel)
}
