//
//  ColorSlider.swift
//  Streambox Connect
//
//  Created by Benj on 08/12/2019.
//  Copyright © 2019 Benji Burgess. All rights reserved.
//

import SwiftUI
import Sliders

/// A linear control for selecting a saturation or brightness value, affecting the color values stored in the shared environment object.
public struct ColorSlider: View {
    
    @EnvironmentObject var colorPickerConfig: ColorPickerConfig
    
    private var hue: Double { colorPickerConfig.hue }
    private var saturation: Double { colorPickerConfig.saturation }
    private var brightness: Double { colorPickerConfig.brightness }
    public static let THUMB_SIZE: CGFloat = 48
    public static let TRACK_HEIGHT: CGFloat = 35
    
    var mode: Mode
    
    var leadingColor: Color {
        guard mode == .saturation else {
            return .init(hue: self.hue, saturation: self.saturation, brightness: 0.0)
        }
        return .init(hue: self.hue, saturation: 0.0, brightness: self.brightness)
    }
    
    var trailingColor: Color {
        
        guard mode == .saturation else {
            return .init(hue: self.hue, saturation: self.saturation, brightness: 1.0)
        }
        return .init(hue: self.hue, saturation: 1.0, brightness: self.brightness)
    }
    var gradient: LinearGradient {
        LinearGradient(
            gradient: .init(colors: [leadingColor, trailingColor]),
            startPoint: .leading, endPoint: .trailing)
    }
    
    public var body: some View {
        HSlider(
            value: self.mode == .saturation ? self.$colorPickerConfig.saturation : self.$colorPickerConfig.brightness,
            track: HTrack(value: 1.0, view: self.gradient, mask: Rectangle())
                .frame(height: ColorSlider.TRACK_HEIGHT)
                .cornerRadius(.infinity),
            thumb: Circle()
                
                .fill(Color(hue: self.hue, saturation: self.saturation, brightness: self.brightness))
                .shadow(color: .init(.sRGBLinear, white: 0, opacity: 0.1), radius: 10, x: 0, y: 0)
                .overlay(Circle().strokeBorder(lineWidth: 6, antialiased: false).foregroundColor(.white).frame(width: 50, height: 50))
                .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0)),
            configuration: .init(
                options: .interactiveTrack,
                thumbSize: .init(width: ColorSlider.THUMB_SIZE, height: ColorSlider.THUMB_SIZE))
        )
    }
    
    public enum Mode {
        case saturation
        case brightness
    }
    
    public init(_ mode: ColorSlider.Mode) {
        self.mode = mode
    }
    
}
