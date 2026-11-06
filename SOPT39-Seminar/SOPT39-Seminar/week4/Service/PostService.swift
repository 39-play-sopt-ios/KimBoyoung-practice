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

    func makeURL(path: String) throws -> URL {
        guard
            let baseURL = Bundle.main.object(
                forInfoDictionaryKey: "BASE_URL"
            ) as? String,
            let url = URL(string: baseURL)
        else {
            throw NetworkError.urlError
        }

        return url.appending(path: path)
    }
}
