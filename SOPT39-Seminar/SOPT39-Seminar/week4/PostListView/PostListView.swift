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
        .overlay {
            if let postToDelete {
                deleteModal(for: postToDelete)
            }
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
        .task {
            guard posts.isEmpty else { return }
            await fetchPosts()
        }
    }

    private func deleteModal(for post: PostResponseDTO) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    postToDelete = nil
                }

            VStack(spacing: 20) {
                Text("게시글을 삭제할까요?")
                    .font(.m18)
                    .tracking(-0.18)
                    .foregroundStyle(Color(.gray6))
                    .frame(maxWidth: .infinity)

                HStack(spacing: 12) {
                    modalButton(
                        title: "취소",
                        backgroundColor: Color(.gray1),
                        foregroundColor: Color(.gray5)
                    ) {
                        postToDelete = nil
                    }

                    modalButton(
                        title: "삭제",
                        backgroundColor: Color(.black),
                        foregroundColor: Color(.gray1)
                    ) {
                        postToDelete = nil
                        Task {
                            await deletePost(post)
                        }
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color(.white), in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 36)
        }
        .ignoresSafeArea()
    }

    private func modalButton(
        title: String,
        backgroundColor: Color,
        foregroundColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.sb14)
                .tracking(-0.14)
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .background(backgroundColor, in: Capsule())
        }
        .buttonStyle(.plain)
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
                            .contentShape(Rectangle())
                            .onLongPressGesture {
                                postToDelete = post
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

            guard response.isSuccess else {
                throw NetworkError.serverError(
                    message: response.message
                )
            }

            let postListResponse = try await PostService.shared.getPosts()
            try Task.checkCancellation()
            posts = postListResponse.data?.posts ?? []
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
            let deleteResponse = try await PostService.shared.deletePost(
                postID: post.id,
                authorizationCode: authorizationCode
            )
            try Task.checkCancellation()

            guard deleteResponse.isSuccess else {
                throw NetworkError.serverError(
                    message: deleteResponse.message
                )
            }

            let postListResponse = try await PostService.shared.getPosts()
            try Task.checkCancellation()
            posts = postListResponse.data?.posts ?? []
        } catch is CancellationError {
        } catch {
            requestErrorMessage = error.localizedDescription
        }
    }
}

#Preview {
    PostListView(posts: PostResponseDTO.samples)
}
