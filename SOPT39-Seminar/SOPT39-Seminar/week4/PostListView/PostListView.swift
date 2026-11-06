//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostListView: View {
    let authorizationCode: String
    let author: String

    @State private var posts: [PostResponseDTO]
    @State private var searchText = ""
    @State private var isPostSheetPresented = false
    @State private var isLoading = false
    @State private var isCreatingPost = false
    @State private var isDeletingPost = false
    @State private var errorMessage = ""
    @State private var requestErrorMessage = ""
    @State private var postToDelete: PostResponseDTO?

    init(
        authorizationCode: String = "",
        author: String = "",
        posts: [PostResponseDTO] = []
    ) {
        self.authorizationCode = authorizationCode
        self.author = author
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
            PostEditorSheet { title, content in
                Task {
                    await createPost(title: title, content: content)
                }
            }
                .presentationDetents([.height(265)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(24)
        }
        .alert(
            "요청 실패",
            isPresented: Binding(
                get: { !requestErrorMessage.isEmpty },
                set: { isPresented in
                    if !isPresented {
                        requestErrorMessage = ""
                    }
                }
            )
        ) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(requestErrorMessage)
        }
        .alert(
            "게시글을 삭제할까요?",
            isPresented: Binding(
                get: { postToDelete != nil },
                set: { isPresented in
                    if !isPresented {
                        postToDelete = nil
                    }
                }
            ),
            presenting: postToDelete
        ) { post in
            Button("삭제", role: .destructive) {
                Task {
                    await deletePost(post)
                }
            }
            Button("취소", role: .cancel) {}
        } message: { _ in
            Text("삭제한 게시글은 복구할 수 없습니다.")
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
                            .contextMenu {
                                if post.author == author {
                                    Button(role: .destructive) {
                                        postToDelete = post
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                            }
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

    @MainActor
    private func createPost(title: String, content: String) async {
        guard !isCreatingPost else { return }

        isCreatingPost = true
        requestErrorMessage = ""
        defer { isCreatingPost = false }

        do {
            let response = try await PostService.shared.createPost(
                title: title,
                content: content,
                author: author,
                authorizationCode: authorizationCode
            )
            try Task.checkCancellation()

            guard let createdPost = response.data else {
                throw NetworkError.responseError
            }
            posts.insert(createdPost, at: 0)
        } catch is CancellationError {
        } catch {
            requestErrorMessage = error.localizedDescription
        }
    }

    @MainActor
    private func deletePost(_ post: PostResponseDTO) async {
        guard !isDeletingPost else { return }

        isDeletingPost = true
        requestErrorMessage = ""
        defer { isDeletingPost = false }

        do {
            _ = try await PostService.shared.deletePost(
                postID: post.id,
                authorizationCode: authorizationCode
            )
            try Task.checkCancellation()
            posts.removeAll { $0.id == post.id }
        } catch is CancellationError {
        } catch {
            requestErrorMessage = error.localizedDescription
        }
    }
}

#Preview {
    PostListView(posts: PostResponseDTO.samples)
}
