//
//  ChartModels.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


struct ChartsContainer {
    
    let charts: [Chart]
    
    init(charts: [Chart]) {
        self.charts = charts
    }
    
}

struct Chart {
    var lines: [Line]
    var x: [Int]
}


public struct Line {
    
    public let name: String
    
    public let values: [Int]
    
    public let color: UIColor
    
    public init(name: String, values: [Int], color: UIColor) {
        self.name = name
        self.values = values
        self.color = color
    }
    
}


enum AxisType: String {
    case x
    case line
}

