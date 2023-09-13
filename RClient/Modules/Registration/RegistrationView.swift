//
//  RegistrationView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack {
            Button("Back") {
                dismiss()
            }
            Text("Reg")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeRegistrationScreenView()
    }
}
