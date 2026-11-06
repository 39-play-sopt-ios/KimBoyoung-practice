//
//  PostListResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

struct PostListResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: PostListDataDTO?
}

struct PostListDataDTO: Decodable {
    let posts: [PostResponseDTO]
    let nextCursor: Int?
    let hasNext: Bool
}
