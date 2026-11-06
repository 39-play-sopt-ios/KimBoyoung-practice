//
//  PostDeleteModal.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostDeleteModal: View {
    let onCancel: () -> Void
    let onDelete: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture(perform: onCancel)

            VStack(spacing: 20) {
                Text("게시글을 삭제할까요?")
                    .font(.m18)
                    .tracking(-0.18)
                    .foregroundStyle(Color(.gray6))
                    .frame(maxWidth: .infinity)

                HStack(spacing: 12) {
                    modalButton(
                        title: "취소",
                        backgroundColor: Color(.gray1),
                        foregroundColor: Color(.gray5),
                        action: onCancel
                    )

                    modalButton(
                        title: "삭제",
                        backgroundColor: Color(.black),
                        foregroundColor: Color(.gray1),
                        action: onDelete
                    )
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color(.white), in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 36)
        }
        .ignoresSafeArea()
    }

    private func modalButton(
        title: String,
        backgroundColor: Color,
        foregroundColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.sb14)
                .tracking(-0.14)
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 49)
                .background(backgroundColor, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PostDeleteModal(onCancel: {}, onDelete: {})
}
