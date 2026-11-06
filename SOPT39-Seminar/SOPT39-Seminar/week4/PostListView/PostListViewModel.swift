//
//  PostListViewModel.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import Combine
import Foundation

final class PostListViewModel: ObservableObject {
    @Published private(set) var posts: [PostResponseDTO]
    @Published private(set) var isLoading = false
    @Published var errorMessage = ""
    @Published var requestErrorMessage = ""

    private let authorizationCode: String
    private let author: String
    private var isCreatingPost = false
    private var isDeletingPost = false

    init(
        authorizationCode: String,
        author: String,
        posts: [PostResponseDTO]
    ) {
        self.authorizationCode = authorizationCode
        self.author = author
        self.posts = posts
    }

    @MainActor
    func fetchPosts() async {
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
    func createPost(title: String, content: String) async {
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

            try await refreshPosts()
        } catch is CancellationError {
        } catch {
            requestErrorMessage = error.localizedDescription
        }
    }

    @MainActor
    func deletePost(_ post: PostResponseDTO) async {
        guard !isDeletingPost else { return }

        isDeletingPost = true
        requestErrorMessage = ""
        defer { isDeletingPost = false }

        do {
            let response = try await PostService.shared.deletePost(
                postID: post.id,
                authorizationCode: authorizationCode
            )
            try Task.checkCancellation()

            guard response.isSuccess else {
                throw NetworkError.serverError(
                    message: response.message
                )
            }

            try await refreshPosts()
        } catch is CancellationError {
        } catch {
            requestErrorMessage = error.localizedDescription
        }
    }

    @MainActor
    private func refreshPosts() async throws {
        let response = try await PostService.shared.getPosts()
        try Task.checkCancellation()
        posts = response.data?.posts ?? []
    }
}
