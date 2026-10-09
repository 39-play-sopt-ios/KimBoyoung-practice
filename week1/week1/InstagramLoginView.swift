//
//  InstagramLoginView.swift
//  week1
//
//  Created by BY on 10/9/26.
//

import SwiftUI

struct InstagramLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isKeepingLogin: Bool = false
    @State private var isShowingProfile: Bool = false

    private var isLoginEnabled: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.logo)
                .padding(.top, 126)
            
            TextField(
                "이메일",
                text: $email,
                prompt: Text("이메일을 입력하세요")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.black.opacity(0.2))
            )
            .font(.system(size: 14, weight: .regular))
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 15)
            .frame(height: 44)
            .background(.gray200)
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.1), lineWidth: 0.5)
            }
            .padding(.horizontal, 16)
            .padding(.top, 44)
            
            SecureField(
                "비밀번호",
                text: $password,
                prompt: Text("비밀번호를 입력하세요")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.black.opacity(0.2))
            )
            .font(.system(size: 14, weight: .regular))
            .textContentType(.password)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 15)
            .frame(height: 44)
            .background(.gray200)
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.1), lineWidth: 0.5)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Toggle("로그인 상태 유지", isOn: $isKeepingLogin)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.black.opacity(0.6))
                .toggleStyle(.switch)
                .tint(.primaryBlue)
                .padding(.horizontal, 16)
                .padding(.top, 12)

            Button {
                isShowingProfile = true
            } label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(isLoginEnabled ? Color.primaryBlue : Color.gray300)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .disabled(!isLoginEnabled)
            .opacity(isLoginEnabled ? 1 : 0.6)
            .animation(.easeInOut(duration: 0.2), value: isLoginEnabled)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isShowingProfile) {
            InstagramProfileView()
        }
    }
}

#Preview {
    InstagramLoginView()
}
