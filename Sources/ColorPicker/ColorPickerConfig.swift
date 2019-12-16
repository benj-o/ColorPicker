//
//  ColorPickerConfig.swift
//  Streambox Connect
//
//  Created by Benj on 10/12/2019.
//  Copyright © 2019 Benji Burgess. All rights reserved.
//

import SwiftUI
import UIKit

public class ColorPickerConfig: ObservableObject {
    
    @Published public var hue: Double = 0.0
    @Published public var saturation: Double = 1.0
    @Published public var brightness: Double = 1.0
    
    public var uiColor: UIColor {
        .init(hue: CGFloat(self.hue), saturation: CGFloat(self.saturation), brightness: CGFloat(self.brightness), alpha: 1.0)
    }
    
    public var color: Color {
        .init(self.uiColor)
    }
    
    public var hex: String {
        self.uiColor.hex
    }
    
    
    public init() {}
}

extension UIColor {
    
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

