//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Hendrik Ulbrich on 15.07.19.
//
//  This code uses:
//    https://developer.apple.com/documentation/swiftui/gestures/composing_swiftui_gestures
//  and
//    https://developer.apple.com/wwdc19/237

import SwiftUI

public struct ColorPicker: View {
    
    @EnvironmentObject var config: ColorPickerConfig
    public var strokeWidth: CGFloat = 30
    
    public var body: some View {
        GeometryReader { geometry -> ColorWheel in
            return ColorWheel(frame: geometry.frame(in: CoordinateSpace.local), width: self.strokeWidth)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    public init(width strokeWidth: CGFloat) {
        self.strokeWidth = strokeWidth
    }
    
}

public struct ColorWheel: View {
    
    @EnvironmentObject var config: ColorPickerConfig
    
    public var frame: CGRect
    @State private var position: CGPoint = CGPoint.zero
    @State private var angle: Angle = 0.0
    public var strokeWidth: CGFloat
    
    public var body: some View {
        let conic = AngularGradient(gradient: Gradient.colorWheelSpectrum, center: .center, angle: .degrees(-90))
        let indicatorOffset = CGSize(width: cos(angle.radians) * Double(frame.midX - strokeWidth / 2), height: -sin(angle.radians) * Double(frame.midY - strokeWidth / 2))
        return ZStack(alignment: .center) {
            Circle()
                .strokeBorder(conic, lineWidth: strokeWidth)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged(self.update(value:))
            )
            Circle()
                .fill(Color(hue: self.config.hue, saturation: self.config.saturation, brightness: self.config.brightness))
                .frame(width: strokeWidth, height: strokeWidth, alignment: .center)
                .fixedSize()
                .offset(indicatorOffset)
                .allowsHitTesting(false)
                .shadow(color: .init(.sRGBLinear, white: 0, opacity: 0.1), radius: 10, x: 0, y: 0)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 6)
                        .offset(indicatorOffset)
                        .allowsHitTesting(false)
            )
                .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0))
            
        }
    }
    
    public init(frame: CGRect, width strokeWidth: CGFloat) {
        self.frame = frame
        self.strokeWidth = strokeWidth
    }
    
    internal func update(value: DragGesture.Value) {
        self.position = value.location
        self.angle = Angle(radians: radCenterPoint(value.location, frame: self.frame))
        self.$config.hue.wrappedValue = angle.radians / (2 * .pi)//Color.fromAngle(angle: self.angle)
    }
    
    internal func radCenterPoint(_ point: CGPoint, frame: CGRect) -> Double {
        let adjustedAngle = atan2f(Float(frame.midX - point.x), Float(frame.midY - point.y)) + .pi / 2
        return Double(adjustedAngle < 0 ? adjustedAngle + .pi * 2 : adjustedAngle)
    }

}
