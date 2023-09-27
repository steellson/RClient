//
//  DetailSectionView.swift
//  RClient
//
//  Created by Andrew Steellson on 20.08.2023.
//

import SwiftUI

struct DetailSectionView: View {
    
    @ObservedObject var viewModel: DetailSectionViewModel
    
    
    var body: some View {
        Text("Detail section")
            .padding(5)

    }
}

#Preview {
    DetailSectionView(viewModel: ViewModelFactoryInstance.makeDetailSectionViewModel())
}
