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
}
