//
//  PostSignUpView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/31/26.
//

import SwiftUI

struct PostSignUpView: View {
    let onSignup: (_ authorizationCode: String, _ name: String) -> Void

    @State private var part = ""
    @State private var name = ""
    @State private var isLoading = false
    @State private var authorizationCode = ""
    @State private var errorMessage = ""

    init(
        onSignup: @escaping (_ authorizationCode: String, _ name: String) -> Void = { _, _ in }
    ) {
        self.onSignup = onSignup
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Group {
                TextField(
                    "web / iOS / android", text: $part)
                
                TextField("이름을 입력해주세요", text: $name)
            }
            .font(.system(size: 18, weight:.medium))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 16)
            .frame(height: 54)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(white: 0.83), lineWidth: 2)
            }
            
            Button {
                Task{
                    await signupButtonDidTap()
                }
            } label: {
                Text(isLoading ? "발급 중..." : "코드 발급")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 49)
                    .background(Color(.black), in: RoundedRectangle(cornerRadius: 12))
            }
            .disabled(isLoading)
            .padding(.top, 8)
            
            Spacer()
            
            if !authorizationCode.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("발급받은 인증 코드")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(authorizationCode)
                        .font(.system(size: 28, weight: .bold))
                        .textSelection(.enabled)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 24)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                   .foregroundStyle(.red)
                   .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 88)
        .background(.white)
    }
    
    private func signupButtonDidTap() async {
        guard !isLoading else { return }

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            errorMessage = "이름을 입력해주세요."
            return
        }
        
        isLoading = true
        authorizationCode = ""
        errorMessage = ""
        defer { isLoading = false }
        
        do {
            let response = try await SignupService.shared.postSignup(part: part)
            try Task.checkCancellation()
            
            guard let code = response.data?.authorizationCode else {
                throw NetworkError.responseError
            }
            authorizationCode = code
            onSignup(code, trimmedName)
        } catch is CancellationError {
            //취소는 요청 실패로 표시하지 않는다.
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    PostSignUpView()
}
