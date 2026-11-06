//
//  SearchTextField.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: $text,
                prompt: Text("검색어를 입력하세요")
                    .foregroundStyle(Color(.gray2))
            )
            .font(.m18)
            .foregroundStyle(Color(.gray5))
            
            Image(.search)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color(.gray3))
        }
        .padding(16)
        .overlay{
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.gray2), lineWidth: 2)
        }
    }
}

#Preview {
    SearchTextField(text: .constant("솝트"))
}
