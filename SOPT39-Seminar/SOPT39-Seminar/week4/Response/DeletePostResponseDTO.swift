//
//  DeletePostResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

struct DeletePostResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
}
