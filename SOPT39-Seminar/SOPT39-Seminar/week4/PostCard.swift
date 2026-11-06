//
//  PostCard.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostCard: View {
    let post: PostResponseDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            authorAndDate
            postContent
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.gray1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var authorAndDate: some View {
        HStack(spacing: 4) {
            Text(post.author)

            Rectangle()
                .fill(Color(.gray3))
                .frame(width: 1, height: 12)

            Text(post.displayDate)
        }
        .font(.m12)
        .foregroundStyle(Color(.gray3))
    }

    private var postContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(post.title)
                .font(.m16)

            Text(post.content)
                .font(.m14)
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(Color(.gray5))
    }
}

#Preview {
    PostCard(post: PostResponseDTO.samples[0])
        .padding()
}

