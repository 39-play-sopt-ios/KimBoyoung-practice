//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel: PostListViewModel

    @State private var searchText = ""
    @State private var isPostSheetPresented = false
    @State private var postToDelete: PostResponseDTO?

    init(
        authorizationCode: String = "",
        author: String = "",
        posts: [PostResponseDTO] = []
    ) {
        _viewModel = StateObject(
            wrappedValue: PostListViewModel(
                authorizationCode: authorizationCode,
                author: author,
                posts: posts
            )
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            SearchTextField(text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            PostListContent(
                posts: viewModel.posts,
                isLoading: viewModel.isLoading,
                errorMessage: viewModel.errorMessage,
                onRetry: {
                    Task { await viewModel.fetchPosts() }
                },
                onRefresh: {
                    await viewModel.fetchPosts()
                },
                onLongPress: { post in
                    postToDelete = post
                }
            )
        }
        .background(Color(.white))
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                isPostSheetPresented = true
            }
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
        .overlay {
            if let postToDelete {
                PostDeleteModal(
                    onCancel: {
                        self.postToDelete = nil
                    },
                    onDelete: {
                        self.postToDelete = nil
                        Task {
                            await viewModel.deletePost(postToDelete)
                        }
                    }
                )
            }
        }
        .sheet(isPresented: $isPostSheetPresented) {
            PostEditorSheet { title, content in
                Task {
                    await viewModel.createPost(
                        title: title,
                        content: content
                    )
                }
            }
            .presentationDetents([.height(265)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(24)
        }
        .alert(
            "요청 실패",
            isPresented: Binding(
                get: { !viewModel.requestErrorMessage.isEmpty },
                set: { isPresented in
                    if !isPresented {
                        viewModel.requestErrorMessage = ""
                    }
                }
            )
        ) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(viewModel.requestErrorMessage)
        }
        .task {
            guard viewModel.posts.isEmpty else { return }
            await viewModel.fetchPosts()
        }
    }

}

#Preview {
    PostListView(posts: PostResponseDTO.samples)
}
