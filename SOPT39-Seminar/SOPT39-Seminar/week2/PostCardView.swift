//
//  PostCardView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct PostCardView: View {
    @Binding var isLiked: Bool
    let profileImage: String
    let username: String
    let location: String
    let postImage: Image
    let likesText: String
    let caption: String
    let timeText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            PostProfileHeaderView(name: username, location: location, image: profileImage)
            
            // 같은 타입 내부의 연산 프로퍼티
            postImageV
            actionIcons
            postInformation
        }
        .background(.white)
        .foregroundStyle(.black)
    }
    private var postImageV: some View {
        postImage
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
    
    private var actionIcons: some View {
        HStack(spacing: 18) {
            
            Button {
                isLiked.toggle()
            } label: {
                Image(isLiked ? "Like" : "Like-2")
            }
            Image(.comment)
            Image(.messanger)
            
            Spacer()
            
            Image(.save)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var postInformation: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(likesText)")
            Text("\(Text("\(username)").bold()) \(caption)")
                .fixedSize(horizontal: false, vertical: true)
            Text("\(timeText)")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .font(.system(size: 14))
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}
