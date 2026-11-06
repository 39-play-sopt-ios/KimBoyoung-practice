//
//  InstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct InstagramFeedView2: View {
    @State private var viewModel = InstagramFeedViewModel()
    
    var body: some View {
        ScrollView([.vertical]) {
            VStack(alignment: .center, spacing: 0){
                Image(.logo)
                    .padding(.bottom, 30)
                
                ForEach(viewModel.examplePosts) { post in
                    PostCardView(
                        profileImage: "Rectangle",
                        username: post.username,
                        location: post.location,
                        postImage: Image(post.postImageName),
                        likesText: post.likesText,
                        caption: post.caption,
                        timeText: post.timeText,
                        isLiked: post.isLiked,
                        onLikedTapped: {
                            viewModel.toggleLike(id: post.id)
                        })
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    InstagramFeedView2()
}
