//
//  PostService+Delete.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import Foundation

extension PostService {
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

    private func makeDeleteRequest(
        postID: Int,
        authorizationCode: String
    ) throws -> URLRequest {
        let url = try makeURL(path: "api/v1/posts/\(postID)")

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(
            authorizationCode,
            forHTTPHeaderField: "Authorization"
        )

        return request
    }
}
