//
//  InstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct InstagramFeedView: View {
    @State private var posts: [PostModel] = examplePosts
    
    var body: some View {
        ScrollView([.vertical]) {
            VStack(alignment: .center, spacing: 10){
                Image(.logo)
                
                ForEach($posts) { $post in
                    PostCardView(
                        isLiked: $post.isLiked,
                        profileImage: post.profileImageName,
                        username: post.username,
                        location: post.location,
                        postImage: Image(post.postImageName),
                        likesText: post.likesText,
                        caption: post.caption,
                        timeText: post.timeText
                                 )
                }
            }
        }
    }
}

#Preview {
    InstagramFeedView()
}
