//
//  PostEditorSheet.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostEditorSheet: View {
    let onSubmit: (_ title: String, _ content: String) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedContent: String {
        content.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var isSubmitEnabled: Bool {
        !trimmedTitle.isEmpty &&
        !trimmedContent.isEmpty &&
        trimmedTitle.count <= 20 &&
        trimmedContent.count <= 1_000
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Capsule()
                .fill(Color(.gray3))
                .frame(width: 36, height: 4)
                .frame(maxWidth: .infinity)
                .padding(.top, 12)
                .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    postTextField(
                        title: "제목",
                        placeholder: "제목을 입력하세요.",
                        text: $title,
                        maxLength: 20
                    )

                    postTextField(
                        title: "본문",
                        placeholder: "본문을 입력하세요.",
                        text: $content,
                        maxLength: 1_000
                    )
                }

                Button(action: submitButtonDidTap) {
                    Text("완료")
                        .font(.sb14)
                        .tracking(-0.14)
                        .foregroundStyle(
                            isSubmitEnabled ? Color(.gray1) : Color(.gray3)
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 49)
                        .background(
                            isSubmitEnabled ? Color(.black) : Color(.gray1),
                            in: Capsule()
                        )
                }
                .buttonStyle(.plain)
                .disabled(!isSubmitEnabled)
            }
            .frame(width: 328)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.white))
    }

    private func postTextField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        maxLength: Int
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.sb16)
                .tracking(-0.16)
                .foregroundStyle(Color(.gray6))
                .padding(.leading, 8)

            TextField(
                "",
                text: text,
                prompt: Text(placeholder)
                    .foregroundStyle(Color(.gray2))
            )
            .font(.m18)
            .tracking(-0.18)
            .foregroundStyle(Color(.gray5))
            .padding(.horizontal, 16)
            .frame(height: 54)
            .background(Color(.white))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.gray2), lineWidth: 2)
            }
            .onChange(of: text.wrappedValue) { _, newValue in
                guard newValue.count > maxLength else { return }
                text.wrappedValue = String(newValue.prefix(maxLength))
            }
        }
    }

    private func submitButtonDidTap() {
        guard isSubmitEnabled else { return }

        onSubmit(trimmedTitle, trimmedContent)
        dismiss()
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            PostEditorSheet { _, _ in }
                .presentationDetents([.height(265)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(24)
        }
}
