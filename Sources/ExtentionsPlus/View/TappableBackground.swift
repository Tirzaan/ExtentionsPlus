//
//  TappableBackground.swift
//  TestPackages
//
//  Created by Tirzaan on 3/17/26.
//

import SwiftUI

@available(iOS 15.0, *)
extension View {
    public func tappableBackground() -> some View {
        background(.black.opacity(0.001))
    }
}
