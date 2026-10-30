//
//  SwiftUIView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 16) {
            Text("현재 값: \(count)")
                .font(.title)
            Button("1 증가") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        
        Button("1 감소") {
            count -= 1
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    CounterView()
}
