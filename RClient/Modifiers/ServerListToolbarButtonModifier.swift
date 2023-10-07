//
//  ServerListToolbarButtonModifier.swift
//  RClient
//
//  Created by Andrew Steellson on 07.10.2023.
//

import SwiftUI

struct ServerListToolbarButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderless)
            .frame(maxWidth: 46, maxHeight: 46)
            .background(.quaternary)
            .clipShape(Circle())
            .shadow(
                color: .black.opacity(0.5),
                radius: 0.8,
                x: -2,
                y: 2
            )
    }
}
