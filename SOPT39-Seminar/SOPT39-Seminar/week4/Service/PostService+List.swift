//
//  PostService+List.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import Foundation

extension PostService {
    func getPosts() async throws -> PostListResponseDTO {
        let request = try makeListRequest()
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

    private func makeListRequest() throws -> URLRequest {
        let url = try makeURL(path: "api/v1/posts")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
