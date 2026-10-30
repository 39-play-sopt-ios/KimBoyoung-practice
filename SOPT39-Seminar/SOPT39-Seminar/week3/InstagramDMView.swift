//
//  InstagramDMView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/17/26.
//

import SwiftUI


struct InstagramDMView: View {
    
    @State private var viewModel = InstagramDMViewModel()
    
    var body: some View {
        List(viewModel.exampleDMs) { message in
            DMModelView(model: message)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: 0,
                        leading: 16,
                        bottom: 16,
                        trailing: 16
                    )
            )
    }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.white)
    }
}

#Preview {
    InstagramDMView()
}
