//
//  LegacyEnvironmentRootView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/17/26.
//

import SwiftUI
import Combine

final class LegacyProfileModel: ObservableObject {
    @Published var nickname = "모아요"
    @Published var isPublic = true
}

struct LegacyEnvironmentRootView: View {
    @StateObject private var profile = LegacyProfileModel()
    
    var body: some View {
        LegacyMiddleView()
                    .environmentObject(profile)
    }
}

struct LegacyMiddleView: View {
    var body: some View {
        LegacyDeepProfileView()
    }
}

struct LegacyDeepProfileView: View {
    @EnvironmentObject private var profile: LegacyProfileModel

    var body: some View {
        Text("깊은 곳에서도: \(profile.nickname)")
    }
}

#Preview {
    LegacyEnvironmentRootView()
}
