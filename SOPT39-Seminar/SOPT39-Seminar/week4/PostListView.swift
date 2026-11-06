//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostListView: View {
    @State private var posts: [PostResponseDTO]
    @State private var searchText = ""
    @State private var isPostSheetPresented = false

    init(posts: [PostResponseDTO]) {
        _posts = State(initialValue: posts)
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            postList
        }
        .background(Color(.white))
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                isPostSheetPresented = true
            }
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
        .sheet(isPresented: $isPostSheetPresented) {
            PostEditorSheet(onSubmit: addPost)
                .presentationDetents([.height(265)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(24)
        }
    }

    private var postList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(posts) { post in
                    PostCard(post: post)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 88)
        }
    }

    private func addPost(title: String, content: String) {
        let nextID = (posts.map(\.id).max() ?? 0) + 1
        let currentDate = Date.now.ISO8601Format()

        let newPost = PostResponseDTO(
            id: nextID,
            title: title,
            content: content,
            author: "김보영",
            createdAt: currentDate,
            updatedAt: currentDate
        )

        posts.insert(newPost, at: 0)
    }
}

#Preview {
    PostListView(posts: PostResponseDTO.samples)
}
