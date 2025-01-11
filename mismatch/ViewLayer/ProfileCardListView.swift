//
//  ProfileCardListView.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftUI

struct ProfileCardListView: View {
    let profileModelList: [ProfileModel]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(profileModelList) { profileModel in
                    ProfileCardView(profileModel: profileModel)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    let profileModelList: [ProfileModel] = [
        ProfileModel(
            id: "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
            firstName: "Jennie",
            lastName: "Nichols",
            streetNumber: "8929",
            streetName: "Valwood Pkwy",
            city: "Billings",
            profileImageURLString: "https://randomuser.me/api/portraits/men/75.jpg"),
        
        ProfileModel(
            id: "25de1f8e-fd7f-479d-b69e-23561d8821b3",
            firstName: "Brianna",
            lastName: "Hanson",
            streetNumber: "1085",
            streetName: "Woodland St",
            city: "Maitland",
            profileImageURLString: "https://randomuser.me/api/portraits/women/9.jpg"),
        
        ProfileModel(
            id: "6819d317-845b-4fc9-9ae8-d0275497602f",
            firstName: "Gordon",
            lastName: "Lewis",
            streetNumber: "5723",
            streetName: "Timber Wolf Trail",
            city: "Bundaberg",
            profileImageURLString: "https://randomuser.me/api/portraits/men/46.jpg"),
        
    ]
    ProfileCardListView(profileModelList: profileModelList)
}
