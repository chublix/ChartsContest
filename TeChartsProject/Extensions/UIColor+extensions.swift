//
//  UIColor+extensions.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hex: String?) {
        guard var hex = hex, !hex.isEmpty else { return nil }
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
        guard let numericValue = Int32(hex, radix: 16) else { return nil }
        self.init(hex: numericValue)
    }
    
    public convenience init(hex: Int32) {
        let red = CGFloat((hex >> 16) & 0xff) / 255.0
        let green = CGFloat((hex >> 8) & 0xff) / 255.0
        let blue = CGFloat(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
