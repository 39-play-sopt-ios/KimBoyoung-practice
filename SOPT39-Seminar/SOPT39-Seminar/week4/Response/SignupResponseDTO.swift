//
//  SignupResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/31/26.
//

struct SignupResponseDTO: Decodable {
    let isSuccess: Bool?
    let code: String?
    let message: String?
    let data: AuthorizationCodeData?
    
    struct AuthorizationCodeData: Decodable {
        let authorizationCode: String?
    }
}


