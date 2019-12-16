//
//  ColorPickerConfig.swift
//  Streambox Connect
//
//  Created by Benj on 10/12/2019.
//  Copyright © 2019 Benji Burgess. All rights reserved.
//

import SwiftUI

public class ColorPickerConfig: ObservableObject {
    @Published var hue: Double = 0.0 // Set initial hue
    @Published var saturation: Double = 1.0
    @Published var brightness: Double = 1.0
    public init() {}
}
