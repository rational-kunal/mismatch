import NeoBrutalism
import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

struct ProfileCardImageView: View {
    let imageUrlString: String
    @State private var isImageLoaded = false

    var body: some View {
        ZStack {
            // Skeleton Placeholder
            if !isImageLoaded {
                RoundSkeleton()
            }

            // Blurred Background Image (Only applies blur after image is loaded)
            WebImage(url: URL(string: imageUrlString))
                .resizable()
                .onSuccess { _, _, _ in
                    DispatchQueue.main.async {
                        withAnimation {
                            isImageLoaded = true
                        }
                    }
                }
                .scaledToFill()
                .blur(radius: isImageLoaded ? 10 : 0)
                .clipped()

            // Clear Centered Image
            WebImage(url: URL(string: imageUrlString))
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .clipShape(Circle())
        }
        .neoBrutalismBox(elevated: false)
    }
}

#Preview {
    ProfileCardImageView(imageUrlString: "https://randomuser.me/api/portraits/men/75.jpg")
}
