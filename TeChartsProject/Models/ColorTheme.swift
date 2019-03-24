//
//  ColorTheme.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

enum ColorTheme: Int {
    case light = 0
    case dark
    
    private static let key: String = "color_theme"
    static var current: ColorTheme! {
        get { return ColorTheme(rawValue: UserDefaults.standard.integer(forKey: key)) }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: key) }
    }
    
    var colors: Colors {
        switch self {
            case .light: return LightThemeColors()
            default: return DarkThemeColors()
            
        }
    }
    
}

protocol Colors {
    var mainBackground: UIColor { get }
    var contentBackground: UIColor { get }
    var axisText: UIColor { get }
    var chartLines: UIColor { get }
    var lineText: UIColor { get }
    var historyTitle: UIColor { get }
}

struct LightThemeColors: Colors {
    
    let mainBackground: UIColor = UIColor(hex: 0xEFEFF3)
    
    let contentBackground: UIColor = .white
    
    let axisText: UIColor = UIColor(hex: 0x616166)
    
    let chartLines: UIColor = UIColor(hex: 0xF3F3F3)
    
    let lineText: UIColor = .black
    
    let historyTitle: UIColor = UIColor(hex: 0x5F6064)
    
}

struct DarkThemeColors: Colors {
    
    let mainBackground: UIColor = UIColor(hex: 0x1A222C)
    
    let contentBackground: UIColor = UIColor(hex: 0x242F3E)
    
    let axisText: UIColor = UIColor(hex: 0x616E81)
    
    let chartLines: UIColor = UIColor(hex: 0x1C2531)
    
    let lineText: UIColor = .white
    
    let historyTitle: UIColor = .white
    
}
