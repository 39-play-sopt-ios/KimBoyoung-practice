//
//  InstagramDMViewModel.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/30/26.
//

import Foundation
import Observation

@Observable
final class InstagramDMViewModel {
    private(set) var exampleDMs: [DMModel] = [
        DMModel(
                profileImageName: "cattaco",
                username: "cattaco",
                message: "타코 내놔라",
                timeText: "지금"
        ),
        DMModel(
                profileImageName: "wolfie",
                username: "cattaco",
                message: "타코 내놔라",
                timeText: "지금"
        ),
        DMModel(
                profileImageName: "horse",
                username: "cattaco",
                message: "타코 내놔라",
                timeText: "지금"
        ),
        DMModel(
                profileImageName: "cattaco",
                username: "cattaco",
                message: "타코 내놔라",
                timeText: "지금"
        ),
        DMModel(
                profileImageName: "cattaco",
                username: "cattaco",
                message: "타코 내놔라",
                timeText: "지금"
        )
            
    ]
}
