//
//  InstagramProfileView.swift
//  week1
//
//  Created by BY on 10/9/26.
//

import SwiftUI

struct InstagramProfileView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.logo)
                .padding(.top, 193)
            
            Image(.instagramProfile)
                .padding(.top, 65)
            
            
            Text("moamoa")
                .font(.system(size: 14, weight: .semibold))
                .padding(.top, 13)
            
            Button {
                // login
            } label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.primaryBlue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
            }
            .padding(.horizontal, 34)
            .padding(.top, 12)
            
            Button("계정 전환") {}
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primaryBlue)
                .padding(.top, 30)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 11) {
                Text("계정이 없으신가요?")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.black.opacity(0.4))
                
                Button {
                    // Sign in
                } label: {
                    Text("회원가입하기.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
            .padding(.bottom, 18)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    InstagramProfileView()
}
