//
//  Rounded.swift
//  TestPackages
//
//  Created by Tirzaan on 3/17/26.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    public func rounded(_ cornerRadius: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

@available(iOS 13.0.0, *)
struct RoundedView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .rounded(10)
            
            Rectangle()
                .frame(width: 100, height: 150)
                .rounded(25)
        }
    }
}

@available(iOS 13.0.0, *)
struct RoundedView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedView()
    }
}
