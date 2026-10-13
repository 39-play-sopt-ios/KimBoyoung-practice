//
//  AILoginPracticeView.swift
//  week1
//
//  Created by BY on 10/10/26.
//

import SwiftUI

struct AILoginPracticeView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Image(.logo)
                .padding(.top, 126)

            VStack(spacing: 12) {
                TextField(
                    "이메일",
                    text: $email,
                    prompt: Text("이메일을 입력하세요")
                        .foregroundStyle(.black.opacity(0.2))
                )
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(
                    .gray200,
                    in: RoundedRectangle(cornerRadius: 5)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.1), lineWidth: 0.5)
                }

                SecureField(
                    "비밀번호",
                    text: $password,
                    prompt: Text("비밀번호를 입력하세요")
                        .foregroundStyle(.black.opacity(0.2))
                )
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(
                    .gray200,
                    in: RoundedRectangle(cornerRadius: 5)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.1), lineWidth: 0.5)
                }
            }
            .font(.system(size: 14, weight: .regular))
            .padding(.top, 44)

            Button("로그인하기") {
                print("로그인 버튼을 눌렀습니다.")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
                email.isEmpty || password.isEmpty
                    ? Color.gray300
                    : Color.primaryBlue,
                in: RoundedRectangle(cornerRadius: 5)
            )
            .padding(.top, 63)
            .disabled(email.isEmpty || password.isEmpty)

            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AILoginPracticeView()
}
