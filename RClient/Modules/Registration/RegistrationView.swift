//
//  RegistrationView.swift
//  RClient
//
//  Created by Andrew Steellson on 24.08.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack {
            Text("Reg")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeRegistrationScreenView()
    }
}
