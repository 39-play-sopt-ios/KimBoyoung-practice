//
//  PostProfileHeaderView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct PostProfileHeaderView: View {
    let name: String
    let location: String
    let image: String
    
    var body: some View {
        HStack(spacing: 10){
            Image("\(image)")
                .resizable()
                .scaledToFill()
                .frame(width:36, height: 36)
                .clipShape(Circle())
            
            VStack (alignment: .leading, spacing: 1) {
                    Text("\(name)")
                    .font(.system(size: 14, weight: .semibold))
                    Text("\(location)")
                    .font(.system(size: 12))
            }
            Spacer()
            
            Image(.moreIcon)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 11)
    }
}
