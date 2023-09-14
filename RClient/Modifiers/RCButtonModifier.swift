//
//  RCButtonModifier.swift
//  RClient
//
//  Created by Andrew Steellson on 14.09.2023.
//

import SwiftUI

struct RCButtonModifier: ViewModifier {
    
    private var strokeColor: Color
    
    init(
        strokeColor: Color
    ) {
        self.strokeColor = strokeColor
    }
    
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 28)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(strokeColor, lineWidth: 0.8)
            }
            .buttonStyle(.borderless)
    }
}
