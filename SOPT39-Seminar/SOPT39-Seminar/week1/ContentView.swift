//
//  ContentView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack (alignment: .bottom){
            Image("cidar")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack{
                VStack(alignment: .leading){
                    Text("김보영")
                        .font(.title)
                    
                    Text("39기 iOS 킹왕짱 와비")
                        .font(.headline)
                }
                
                Spacer()
            }
            .padding()
            .foregroundStyle(.primary)
            .background(.white.opacity(0.75))
            
        }
    }
}

#Preview {
    ContentView()
}
