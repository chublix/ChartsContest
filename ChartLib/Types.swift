//
//  Types.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import Foundation

internal struct RawChartItem: Decodable {
    let columns: [[String]]
    let types: [String: String]
    let names: [String: String]
    let colors: [String: String]
}


public struct ChartItem {
    
    public let columns: [ChartColumn]
    
    init(data: Data) {
        guard let rawItems = try? JSONDecoder().decode([RawChartItem].self, from: data) else {
            self.columns = []
            return
        }
        self.columns = rawItems.map { (item) -> [ChartColumn] in
            let keys = item.columns.compactMap { $0.first }
            keys.map { key -> ChartColumn in
                let values = item.columns.first(where: { $0.first == key })
                let type = ChartColumn.ColumnType(rawValue: item.types[key]!)
                let color = UIColor(hex: item.colors[key]!)
                return ChartColumn(name: item.names[key], values: [], type: type!, color: color)
            }
            return []
        }.flatMap { $0 }
    }
    
}


public struct ChartColumn {
    public let name: String?
    public let values: [Int]
    public let type: ColumnType
    public let color: UIColor?
}

extension ChartColumn {
    
    public enum ColumnType: String {
        case x
        case line
    }
    
}

