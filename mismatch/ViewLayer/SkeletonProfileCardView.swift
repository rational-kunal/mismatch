import NeoBrutalism
import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

struct SkeletonProfileCardView: View {
    var body: some View {
        Card {
            Group {
                RoundSkeleton()
            }.neoBrutalismBox(elevated: false)

            TextSkeleton()

            TextSkeleton()
                .frame(width: 130)
        }
    }
}

#Preview {
    SkeletonProfileCardView()
}
