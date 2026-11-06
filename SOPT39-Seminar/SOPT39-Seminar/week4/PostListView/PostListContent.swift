//
//  PostListContent.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

struct PostListContent: View {
    let posts: [PostResponseDTO]
    let isLoading: Bool
    let errorMessage: String
    let onRetry: () -> Void
    let onRefresh: () async -> Void
    let onLongPress: (PostResponseDTO) -> Void

    var body: some View {
        if isLoading && posts.isEmpty {
            Spacer()
            ProgressView()
            Spacer()
        } else if !errorMessage.isEmpty && posts.isEmpty {
            Spacer()

            VStack(spacing: 12) {
                Text(errorMessage)
                    .font(.m14)
                    .foregroundStyle(Color(.gray5))
                    .multilineTextAlignment(.center)

                Button("다시 시도", action: onRetry)
                    .font(.sb14)
                    .foregroundStyle(Color(.red))
            }

            Spacer()
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(posts) { post in
                        PostCard(post: post)
                            .contentShape(Rectangle())
                            .onLongPressGesture {
                                onLongPress(post)
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 88)
            }
            .refreshable {
                await onRefresh()
            }
        }
    }
}

#Preview {
    PostListContent(
        posts: PostResponseDTO.samples,
        isLoading: false,
        errorMessage: "",
        onRetry: {},
        onRefresh: {},
        onLongPress: { _ in }
    )
}
