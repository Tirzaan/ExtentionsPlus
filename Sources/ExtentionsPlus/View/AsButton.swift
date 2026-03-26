//
//  AsButton.swift
//  TestPackages
//
//  Created by Tirzaan on 3/12/26.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension View {
    private func tapableButton(action: @escaping () -> Void) -> some View {
        onTapGesture {
            action()
        }
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @available(iOS 15.0, *)
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle(color: .blue))
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    private func customButton(scale: CGFloat = 1, opacity: Double = 1, angle: Angle = .degrees(0), duration: Double = 0.25, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(CustomButtonStyle(scale: scale, opacity: opacity, duration: duration, angle: angle))
    }
    
    @ViewBuilder
    public func asButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .press:
            self.pressableButton(action: action)
        case .highlight:
            if #available(iOS 15.0, *) {
                self.highlightButton(action: action)
            } else {
               self
            }
        case .plain:
            self.plainButton(action: action)
        case .tap:
            self.tapableButton(action: action)
        }
    }
    
    public func asButton(scale: CGFloat = 1, opacity: Double = 1, angle: Angle = .degrees(0), duration: Double = 0.25, action: @escaping () -> Void) -> some View {
        customButton(scale: scale, opacity: opacity, angle: angle, duration: duration) {
            action()
        }
    }
    
    public func asButton(scale: CGFloat = 1, opacity: Double = 1, degrees: Double, duration: Double = 0.25, action: @escaping () -> Void) -> some View {
        let angle = Angle(degrees: degrees)
        
        return customButton(scale: scale, opacity: opacity, angle: angle, duration: duration) {
            action()
        }
    }
}

public enum ButtonStyleOption {
    case highlight
    case press
    case tap
    case plain
}

@available(iOS 13.0, *)
struct CustomButtonStyle: ButtonStyle {
    var scale: CGFloat
    var opacity: Double
    var duration: Double
    var angle: Angle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? opacity : 1)
            .rotationEffect(configuration.isPressed ? angle : Angle(degrees: 0))
            .animation(.smooth(duration: duration), value: configuration.isPressed)
    }
}

@available(iOS 13.0.0, *)
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth(duration: 0.25), value: configuration.isPressed)
    }
}

@available(iOS 15.0, *)
struct HighlightButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? color.opacity(0.4) : color.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

@available(iOS 13.0.0, *)
struct AsButtonView: View {
    var body: some View {
        VStack {
            Text("Highlight")
                .padding()
                .padding(.horizontal)
                .background(Color.blue.opacity(0.001))
                .asButton(.highlight) { }
                .rounded(10)
            
            Text("Press")
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .rounded(10)
                .asButton(.press) { }
            
            Text("Tap")
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .rounded(10)
                .asButton(.tap) { }
            
            Text("Plain")
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .rounded(10)
                .asButton(.plain) { }
            
            Text("Custom")
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .rounded(10)
                .asButton(scale: 0.5, opacity: 0.5, degrees: 360, duration: 1) { }
        }
    }
}

@available(iOS 13.0.0, *)
struct AsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AsButtonView()
    }
}
