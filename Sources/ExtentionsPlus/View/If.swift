//
//  If.swift
//  TestPackages
//
//  Created by Tirzaan on 3/19/26.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    @ViewBuilder
    public func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func `if`<Content: View, ElseContent: View>(
        _ condition: Bool,
        transform: (Self) -> Content,
        else elseTransform: (Self) -> ElseContent
    ) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}
