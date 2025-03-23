import NeoBrutalism
import SwiftUI

struct NoLikesAlertView: View {
    var body: some View {
        Alert {
            Text("Like some profiles to see them here!")
                .font(.title3)
        } icon: {
            Image(systemName: "person.crop.circle")
                .font(.largeTitle)
        } head: {
            Text("No likes yet")
                .font(.title)
        }
    }
}

#Preview {
    NoLikesAlertView()
}
