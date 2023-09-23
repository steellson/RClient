//
//  NavigationSectionView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct NavigationSectionView: View {
    
    @ObservedObject var viewModel: NavigationSectionViewModel
    
    
    var body: some View {
        Text("Navigation bar")
            .padding(5)
    }
}

struct NavigationSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeNavigationSectionView()
    }
}
