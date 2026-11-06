//
//  Font+.swift
//  SOPT39-Seminar
//
//  Created by BY on 11/6/26.
//

import SwiftUI

enum PretendardWeight: String {
    case regular  = "Pretendard-Regular"
    case medium   = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    case bold     = "Pretendard-Bold"
}

extension Font {
    static func pretendard(
        _ weight: PretendardWeight,
        size: CGFloat
    ) -> Font {
        .custom(weight.rawValue, size: size)
    }


    static let b28 = pretendard(.bold, size: 28)

    static let m18 = pretendard(.medium, size: 18)

    static let sb16 = pretendard(.semiBold, size: 16)
    static let m16 = pretendard(.medium, size: 16)

    static let sb14 = pretendard(.semiBold, size: 14)
    static let m14 = pretendard(.medium, size: 14)
    static let r14 = pretendard(.regular, size: 14)

    static let m12 = pretendard(.medium, size: 12)
}
