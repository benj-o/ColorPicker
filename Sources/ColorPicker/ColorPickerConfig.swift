//
//  ColorPickerConfig.swift
//  Streambox Connect
//
//  Created by Benj on 10/12/2019.
//  Copyright © 2019 Benji Burgess. All rights reserved.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
#elseif canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
#else
#error("Unsupported platform.")
#endif

public class ColorPickerConfig: ObservableObject {
    
    @Published public var hue: Double = 0.0
    @Published public var saturation: Double = 1.0
    @Published public var brightness: Double = 1.0
    
    #if !canImport(AppKit)
    
    public var uiColor: PlatformColor {
        .init(hue: CGFloat(self.hue), saturation: CGFloat(self.saturation), brightness: CGFloat(self.brightness), alpha: 1.0)
    }
    
    private var platformColor: PlatformColor {
        self.uiColor
    }
    
    #else
    
    public var nsColor: PlatformColor {
        .init(hue: CGFloat(self.hue), saturation: CGFloat(self.saturation), brightness: CGFloat(self.brightness), alpha: 1.0)
    }
    
    private var platformColor: PlatformColor {
        self.nsColor
    }
    
    #endif
    
    public var color: Color {
        .init(self.platformColor)
    }
    
    public var hex: String {
        self.platformColor.hex
    }
    
    
    public init() {}
}

extension PlatformColor {
    
    public var hex: String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "FFFFFF"
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
}

