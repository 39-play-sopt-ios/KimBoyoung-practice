//
//  DMModelView.swift
//  SOPT39-Seminar
//
//  Created by BY on 10/17/26.
//

import SwiftUI

struct DMModelView: View {
    let model: DMModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Image("\(model.profileImageName)")
                .resizable()
                .frame(width: 56, height: 56)
                .clipShape(.circle)
                .padding(.trailing, 12)
            
            VStack(alignment: .leading, spacing: 0){
                Text("\(model.username)")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.bottom, 1)
                
                Text("\(model.message)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray300)
            }
            
            Spacer()
            
            Text("\(model.timeText)")
                .font(.system(size: 13))
                .foregroundStyle(.gray300)
                .padding(.top, 29)
                .padding(.trailing, 32)
                .padding(.bottom, 11)
            
            Image(.pictureIcon)
                .frame(width: 23, height: 22)
                .padding(.vertical, 25)
        }
    }
}

#Preview {
    DMModelView(model: InstagramDMViewModel().exampleDMs[0])
}
