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
    @State private var isLoading = false
    @State private var errorMessage = ""

    init(posts: [PostResponseDTO] = []) {
        _posts = State(initialValue: posts)
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            postListContent
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
        .task {
            guard posts.isEmpty else { return }
            await fetchPosts()
        }
    }

    @ViewBuilder
    private var postListContent: some View {
        if isLoading && posts.isEmpty {
            Spacer()
            ProgressView()
            Spacer()
        } else if !errorMessage.isEmpty && posts.isEmpty {
            Spacer()

            VStack(spacing: 12) {
                Text(errorMessage)
                    .font(.m14)
                    .foregroundStyle(Color(.gray5))
                    .multilineTextAlignment(.center)

                Button("다시 시도") {
                    Task { await fetchPosts() }
                }
                .font(.sb14)
                .foregroundStyle(Color(.red))
            }

            Spacer()
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(posts) { post in
                        PostCard(post: post)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 88)
            }
            .refreshable {
                await fetchPosts()
            }
        }
    }

    @MainActor
    private func fetchPosts() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = ""
        defer { isLoading = false }

        do {
            let response = try await PostService.shared.getPosts()
            try Task.checkCancellation()
            posts = response.data?.posts ?? []
        } catch is CancellationError {
        } catch {
            errorMessage = error.localizedDescription
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
