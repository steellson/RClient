//
//  TextFieldModifier.swift
//  RClient
//
//  Created by Andrew Steellson on 14.09.2023.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {

    private var strokeColor: Color
    
    init(
        strokeColor: Color
    ) {
        self.strokeColor = strokeColor
    }
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .frame(width: 280)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(strokeColor, lineWidth: 0.8)
            }
    }
}
