//
//  ContentView2.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/3/26.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        Button{
            print("프로필 열기!")
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "person.fill")
                Text("프로필 보기")
            }
        }
        
        //
        VStack(spacing: 20) {
            Button {
                print("버튼을 눌렀어요!")
            } label: {
                Label("인사하기", systemImage:
                        "hand.wave.fill")
                .buttonStyle(.borderedProminent)
            }
            Button(action: signIn) {
                Text("Sign in")
            }
            .buttonStyle(.bordered)
                
            Button {
                print("프로필 열기")
            } label: {
                HStack(spacing: 8){
                    Image(systemName: "person.fill")
                    Text("프로필 보기")
                }
            }
            .buttonStyle(.plain)
                
            Button("로그인") {
                print("로그인 완료!")
            }
        }
            
    }
}

struct InputView: View {
    //상태 프로퍼티는 body 바깥에서 선언.
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16){
            TextField("이메일", text: $email)
            SecureField("비밀번호", text: $password)
        
            Text("입력한 이메일: ₩(email)")
            
            Button("예시 이메일 넣기") {
                            email = "sopt@example.com"
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding()
    }
}

private func signIn() {
    print("회원가입 완료!")
}

#Preview {
    ContentView2()
    InputView()
}

