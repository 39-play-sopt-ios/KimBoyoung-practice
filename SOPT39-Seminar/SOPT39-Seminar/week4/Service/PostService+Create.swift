//
//  PostService+Create.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import Foundation

extension PostService {
    func createPost(
        title: String,
        content: String,
        author: String,
        authorizationCode: String
    ) async throws -> CreatePostResponseDTO {
        let body = try makeCreateRequestBody(
            title: title,
            content: content,
            author: author
        )
        let request = try makeCreateRequest(
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

    private func makeCreateRequestBody(
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

    private func makeCreateRequest(
        body: Data,
        authorizationCode: String
    ) throws -> URLRequest {
        let url = try makeURL(path: "api/v1/posts")

        var request = URLRequest(url: url)
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
}
