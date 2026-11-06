//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostListView: View {
    let posts: [PostResponseDTO]

    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            postList
        }
        .background(Color(.white))
    }

    private var postList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(posts) { post in
                    PostCard(post: post)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    PostListView(posts: PostResponseDTO.samples)
}
