//
//  AIInstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created for AI comparison practice.
//

import SwiftUI

struct AIInstagramFeedView: View {
    @State private var posts: [AIPostModel] = AIExamplePosts

    var body: some View {
        VStack(spacing: 0) {
            feedHeader

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach($posts) { $post in
                        AIPostCardView(post: $post)
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }

    private var feedHeader: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 107, height: 24)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
    }
}

private struct AIPostCardView: View {
    @Binding var post: AIPostModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            profileHeader
            postImage
            actionIcons
            postInformation
        }
        .background(Color(.systemBackground))
    }

    private var profileHeader: some View {
        HStack(spacing: 10) {
            Image(post.profileImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 1) {
                Text(post.username)
                    .font(.footnote)
                    .fontWeight(.semibold)

                Text(post.location)
                    .font(.caption2)
            }

            Spacer()

            Image("More Icon")
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 10)
        .frame(height: 54)
    }

    private var postImage: some View {
        ZStack(alignment: .topTrailing) {
            Image(post.postImageName)
                .resizable()
                .scaledToFill()
                .aspectRatio(1, contentMode: .fit)
                .clipped()

            Text(post.photoNumberText)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.7))
                .clipShape(Capsule())
                .padding(14)
        }
    }

    private var actionIcons: some View {
        HStack(spacing: 18) {
            Button {
                post.isLiked.toggle()
            } label: {
                Image(post.isLiked ? "Like" : "Like-2")
            }
            .buttonStyle(.plain)

            Image("Comment")
            Image("Messanger")

            Spacer()

            Image("Save")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }

    private var postInformation: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 7) {
                Image(post.profileImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 17, height: 17)
                    .clipShape(Circle())

                Text(post.likesText)
                    .font(.footnote)
            }

            Text("\(Text(post.username).bold()) \(post.caption)")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)

            Text(post.timeText)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 15)
        .padding(.bottom, 38)
    }
}

private struct AIPostModel: Identifiable {
    let id = UUID()
    let profileImageName: String
    let username: String
    let location: String
    let postImageName: String
    let photoNumberText: String
    let likesText: String
    let caption: String
    let timeText: String
    var isLiked = false
}

private let AIExamplePosts: [AIPostModel] = [
    AIPostModel(
        profileImageName: "instagramProfile",
        username: "moamoa",
        location: "서울, 대한민국",
        postImageName: "Rectangle",
        photoNumberText: "1/3",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "벌써 2차 세미나라니 정말 즐거워요!",
        timeText: "1시간 전"
    ),
    AIPostModel(
        profileImageName: "instagramProfile",
        username: "moamoa",
        location: "서울, 대한민국",
        postImageName: "Rectangle",
        photoNumberText: "1/3",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "벌써 2차 세미나라니 정말 즐거워요!",
        timeText: "1시간 전"
    )
]

#Preview {
    AIInstagramFeedView()
}
