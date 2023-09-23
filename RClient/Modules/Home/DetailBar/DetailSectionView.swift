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
            .frame(minWidth: 160)
    }
}

struct DetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        screenFactory.makeDetailSectionView()
    }
}
