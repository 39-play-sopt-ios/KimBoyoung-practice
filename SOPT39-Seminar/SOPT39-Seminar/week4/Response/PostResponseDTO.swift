//
//  PostResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

struct PostResponseDTO: Identifiable, Decodable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let createdAt: String
    let updatedAt: String
}

extension PostResponseDTO {
    static let samples: [PostResponseDTO] = [
        PostResponseDTO(
            id: 1,
            title: "솝트 4차 세미나",
            content: "아이 재밌다 최고의 팀 아요의 숲",
            author: "김보영",
            createdAt: "2026-11-06T19:30:00",
            updatedAt: "2026-11-06T19:30:00"
        ),
        PostResponseDTO(
            id: 2,
            title: "SwiftUI 화면 구현",
            content: "피그마 디자인을 참고해서 게시글 목록 화면을 구현했습니다.",
            author: "김뿡",
            createdAt: "2026-11-05T18:20:00",
            updatedAt: "2026-11-05T18:20:00"
        )
    ]
}
