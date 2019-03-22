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
    
    init?(from data: Data) {
        guard let rawItems = try? JSONDecoder().decode([JsonChartItem].self, from: data) else { return nil }
        let charts = rawItems.map { (item) -> Chart in
            let lines = item.columns.compactMap { column -> Line? in
                guard let id = column.first?.string, let name = item.names[id] else { return nil }
                guard let color = UIColor(hex: item.colors[id]) else { return nil }
                //                guard let typeID = item.types[id], AxisType(rawValue: typeID) == .line else { return nil }
                let values = column.compactMap { $0.int }
                return Line(name: name, values: values, color: color)
            }
            let xAxisValues = item.columns.first { $0.first?.string == "x" }?.compactMap { $0.int } ?? []
            return Chart(lines: lines, x: xAxisValues)
        }
        self.init(charts: charts)
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

