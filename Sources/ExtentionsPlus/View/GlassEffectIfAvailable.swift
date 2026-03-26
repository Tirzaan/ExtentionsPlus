//
//  GlassEffectIfAvailable.swift
//  TestPackages
//
//  Created by Tirzaan on 3/17/26.
//

//import SwiftUI
//
//extension View {
//    @ViewBuilder
//    func glassEffectIfAvailable(@ViewBuilder else elseContent: @escaping () -> some View) -> some View {
//        #if canImport(SwiftUI)
//        if #available(iOS 26.0, macOS 15.0, tvOS 20.0, watchOS 11.0, *) {
//            self.glassEffect()
//        } else {
//            elseContent()
//        }
//        #else
//        self
//        #endif
//    }
//    
//    @ViewBuilder
//    func glassEffectIfAvailable(useDefault: Bool = true) -> some View {
//        if useDefault {
//            foregroundStyle(.ultraThinMaterial)
//        } else {
//            glassEffectIfAvailable { self }
//        }
//    }
//}

import SwiftUI

/// Our own enum for glass styles – safe to use on any iOS version.
/// Maps to the real `Glass` / `GlassEffect.Style` only when available.
enum GlassStyle: String, CaseIterable {
    case regular    // Default medium translucency, adaptive
    case clear      // High transparency, for media-rich / floating controls
    case prominent  // bolder / thicker appearance
}

enum FallbackMode {
    case material
    case fallbackContent
    case none
}

@available(iOS 13.0, *)
extension View {
    /// Applies Apple's Liquid Glass effect when available (iOS 26+, macOS 15.0+, etc.),
    /// with a customizable fallback for older OS versions.
    ///
    /// - Parameters:
    ///   - style: The glass style (from our `GlassStyle` enum). Defaults to `.regular`.
    ///   - interactive: If true, applies the interactive variant for morphing/animations (iOS 26+ only).
    ///   - shape: The shape to clip/apply the glass effect (default: Capsule).
    ///   - fallbackToMaterial: If true on older OS, applies `.ultraThinMaterial` as fallback.
    ///   - fallbackContent: Custom fallback view builder when glass isn't available and fallbackToMaterial is false.
    @ViewBuilder
        func liquidGlass(
            style: GlassStyle = .regular,
            interactive: Bool = false,
            in shape: some InsettableShape = Capsule(),
            useCurrentColor: Bool = false,
            fallbackMode: FallbackMode = .material,
            @ViewBuilder fallbackContent: () -> some View = { EmptyView() }
        ) -> some View {
            if #available(iOS 26.0, macOS 15.0, tvOS 20.0, watchOS 11.0, *) {
                var glass: Glass {
                    switch style {
                    case .regular:    var g = Glass.regular;    if interactive { g = g.interactive() }; return g
                    case .clear:      var g = Glass.clear;      if interactive { g = g.interactive() }; return g
                    case .prominent:  var g = Glass.regular;    if interactive { g = g.interactive() }; return g  // adjust if .prominent exists
                    }
                }
                self.glassEffect(glass, in: shape)
            } else if fallbackMode == .material {
                if useCurrentColor {
                    if #available(iOS 15.0, *) {
                        self.background(.ultraThinMaterial, in: shape)
                            .overlay(
                                shape
                                    .strokeBorder(.white.opacity(0.18), lineWidth: 0.5)
                            )
                    } else {
                        self
                    }
                } else {
                    if #available(iOS 15.0, *) {
                        self.foregroundStyle(.ultraThinMaterial)
                            .overlay(
                                shape
                                    .strokeBorder(.white.opacity(0.18), lineWidth: 0.5)
                            )
                    } else {
                        self
                    }
                }
            } else if fallbackMode == .fallbackContent {
                fallbackContent()
            } else {
                self
            }
        
    }
}

@available(iOS 14.0.0, *)
struct GlassEffectView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.red, .green, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Rectangle()
                .frame(width: 50)
                .ignoresSafeArea()
            
            VStack {
                Circle()
                    .frame(width: 180)
                    .liquidGlass()
                
                
                Circle()
                    .frame(width: 180)
                    .liquidGlass(fallbackMode: .fallbackContent) {
                        Rectangle()
                            .frame(width: 180, height: 180)
                    }
                
                Divider()
                
                if #available(iOS 26.0, *) {
                    Circle()
                        .frame(width: 180)
                        .glassEffect()
                } else {
                    Circle()
                        .fill(.white)
                        .frame(width: 180)
                        .opacity(0.5)
                }
                
                if #available(iOS 26.0, *) {
                    Circle()
                        .frame(width: 180)
                        .glassEffect()
                } else {
                    if #available(iOS 15.0, *) {
                        Circle()
                            .frame(width: 180)
                            .foregroundStyle(.ultraThinMaterial)
                    } else {
                        Circle()
                            .frame(width: 180)
                    }
                }
            }
        }
    }
}

@available(iOS 14.0.0, *)
struct GlassEffectView_Previews: PreviewProvider {
    static var previews: some View {
        GlassEffectView()
    }
}
