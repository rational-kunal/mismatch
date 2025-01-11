//
//  ProfileCardImageView.swift
//  mismatch
//
//  Created by Kunal Kamble on 11/01/25.
//

import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

struct ProfileCardImageView: View {
    let imageURLString: String

    var body: some View {
        WebImage(url: URL(string: imageURLString)) { image in
            image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
        } placeholder: {
            // TODO: Update placeholder -- Maybe skeleton
            Rectangle().foregroundColor(.secondary.opacity(0.2))
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFit()
    }
}

#Preview {
    ProfileCardImageView(imageURLString: "https://randomuser.me/api/portraits/men/75.jpg")
}
