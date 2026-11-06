//
//  CreatePostRequestDTO.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

struct CreatePostRequestDTO: Encodable {
    let title: String
    let content: String
    let author: String
}
