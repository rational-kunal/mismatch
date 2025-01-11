//
//  ProfileCardButtonView.swift
//  mismatch
//
//  Created by Kunal Kamble on 12/01/25.
//

import SwiftUI

struct ProfileCardButtonView: View {
    let text: String
    let selected: Bool
    let backgroundColor: Color
    let action: () -> Void

    init(text: String, selected: Bool = false, backgroundColor: Color = .clear, action: @escaping () -> Void) {
        self.text = text
        self.selected = selected
        self.backgroundColor = backgroundColor
        self.action = action
    }

    var background: some View {
        RoundedRectangle(cornerRadius: SpacingConstants.large)
            .fill(backgroundColor.opacity(selected ? 1.0 : 0.2))
            .stroke(backgroundColor, lineWidth: SpacingConstants.extraSmall)
    }

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .font(.title)
                .padding(SpacingConstants.medium)
                .frame(maxWidth: .infinity)
        }
        .background(background)
    }
}

#Preview {
    ProfileCardButtonView(text: "👍", selected: false, backgroundColor: .secondary) {}
}
