//
//  PostService.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import Foundation

final class PostService {
    static let shared = PostService()

    private init() {}

    private func makeRequest() throws -> URLRequest {
        guard
            let baseURL = Bundle.main.object(
                forInfoDictionaryKey: "BASE_URL"
            ) as? String,
            let url = URL(string: baseURL)
        else {
            throw NetworkError.urlError
        }

        var request = URLRequest(
            url: url.appending(path: "api/v1/posts")
        )
        request.httpMethod = "GET"

        return request
    }

    private func makeRequestBody(
        title: String,
        content: String,
        author: String
    ) throws -> Data {
        do {
            return try JSONEncoder().encode(
                CreatePostRequestDTO(
                    title: title,
                    content: content,
                    author: author
                )
            )
        } catch {
            throw NetworkError.requestEncodingError
        }
    }

    private func makeRequest(
        body: Data,
        authorizationCode: String
    ) throws -> URLRequest {
        guard
            let baseURL = Bundle.main.object(
                forInfoDictionaryKey: "BASE_URL"
            ) as? String,
            let url = URL(string: baseURL)
        else {
            throw NetworkError.urlError
        }

        var request = URLRequest(
            url: url.appending(path: "api/v1/posts")
        )
        request.httpMethod = "POST"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.setValue(
            authorizationCode,
            forHTTPHeaderField: "Authorization"
        )
        request.httpBody = body

        return request
    }

    private func makeDeleteRequest(
        postID: Int,
        authorizationCode: String
    ) throws -> URLRequest {
        guard
            let baseURL = Bundle.main.object(
                forInfoDictionaryKey: "BASE_URL"
            ) as? String,
            let url = URL(string: baseURL)
        else {
            throw NetworkError.urlError
        }

        var request = URLRequest(
            url: url.appending(path: "api/v1/posts/\(postID)")
        )
        request.httpMethod = "DELETE"
        request.setValue(
            authorizationCode,
            forHTTPHeaderField: "Authorization"
        )

        return request
    }

    func getPosts() async throws -> PostListResponseDTO {
        let request = try makeRequest()
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(
                PostListResponseDTO.self,
                from: data
            )
        } catch {
            throw NetworkError.responseDecodingError
        }
    }

    func createPost(
        title: String,
        content: String,
        author: String,
        authorizationCode: String
    ) async throws -> CreatePostResponseDTO {
        let body = try makeRequestBody(
            title: title,
            content: content,
            author: author
        )
        let request = try makeRequest(
            body: body,
            authorizationCode: authorizationCode
        )
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(
                CreatePostResponseDTO.self,
                from: data
            )
        } catch {
            throw NetworkError.responseDecodingError
        }
    }

    func deletePost(
        postID: Int,
        authorizationCode: String
    ) async throws -> DeletePostResponseDTO {
        let request = try makeDeleteRequest(
            postID: postID,
            authorizationCode: authorizationCode
        )
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(
                DeletePostResponseDTO.self,
                from: data
            )
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
