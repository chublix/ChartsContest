//
//  ChartModels.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


struct ChartsContainer {
    
    var charts: [Chart]
    
    init(charts: [Chart]) {
        self.charts = charts
    }
    
}

struct Chart {
    var lines: [Line]
    let x: [Int]
}


struct Line {
    
    let name: String
    let values: [Int]
    let color: UIColor
    var enabled: Bool = true
    
    init(name: String, values: [Int], color: UIColor) {
        self.name = name
        self.values = values
        self.color = color
    }
    
}


enum AxisType: String {
    case x
    case line
}

