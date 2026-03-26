//
//  HexInit.swift
//  TestPackages
//
//  Created by Tirzaan on 3/17/26.
//

import SwiftUI

@available(iOS 13.0, *)
extension Color {
    public init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}
