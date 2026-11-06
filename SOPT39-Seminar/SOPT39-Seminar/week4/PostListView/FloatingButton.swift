//
//  FloatingButton.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.plus)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .frame(width: 60, height: 60)
                .background(Color(.red))
                .clipShape(.circle)
                .shadow(color: .black.opacity(0.15),
                        radius: 3,
                        x: 0,
                        y: 4
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FloatingButton{
        print("플로팅 버튼 클릭")
    }
}
