//
//  SOPT39_SeminarApp.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/3/26.
//

import SwiftUI

@main
struct SOPT39_SeminarApp: App {
    @State private var authorizationCode: String?
    @State private var author = ""

    var body: some Scene {
        WindowGroup {
            if let authorizationCode {
                PostListView(
                    authorizationCode: authorizationCode,
                    author: author
                )
            } else {
                PostSignUpView { code, name in
                    authorizationCode = code
                    author = name
                }
            }
        }
    }
}
