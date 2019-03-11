//
//  Types.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/11/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import Foundation


public struct ChartItem {
    let columns: [ChartColumn]
}


public struct ChartColumn {
    let name: String
    let values: [Int]
    let type: Type
    let color: UIColor?
}

extension ChartColumn {
    
    public enum `Type`: String {
        case x
        case line
    }
    
}



