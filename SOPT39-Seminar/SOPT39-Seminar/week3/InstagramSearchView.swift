//
//  InstagramSearchView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/17/26.
//

import SwiftUI

struct InstagramSearchView: View {
    @State private var searchText = ""
    
    private let columnCount = 3
    private let rowCount = 6
    
    var body: some View {
        VStack(spacing: 23) {
            searchBar
            
            ScrollView {
                Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<6,id: \.self) { row in
                        GridRow {
                            ForEach(0..<3, id: \.self) { column in
                                let index = row * 3 + column
                                
                                Color.clear
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay {
                                        Image("Rectangle\(index)")
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    .clipped()
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 13) {
            TextField("검색", text: $searchText)
                .font(.system(size: 13))
                .padding(.horizontal, 11)
                .frame(height: 36)
                .background(.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray200, lineWidth: 0.5)
                }
            Image(systemName: "bookmark")
                .font(.system(size: 20))
            }
            .padding(.horizontal, 11)
            .padding(.top, 8)
        }
}

#Preview {
    InstagramSearchView()
}
