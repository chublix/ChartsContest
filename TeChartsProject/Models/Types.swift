//
//  Types.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


public struct ChartItem {
    
    public let columns: [ChartColumn]
    
    public init(columns: [ChartColumn]) {
        self.columns = columns
    }
    
}


public struct ChartColumn {
    
    public let name: String?
    
    public let values: [Int]
    
    public let type: ColumnType
    
    public let color: UIColor?
    
    public init(name: String?, values: [Int], type: ColumnType, color: UIColor?) {
        self.name = name
        self.values = values
        self.type = type
        self.color = color
    }
    
}

extension ChartColumn {
    
    public enum ColumnType: String {
        case x
        case line
    }
    
}

