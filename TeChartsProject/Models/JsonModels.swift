//
//  JsonModels.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/21/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import Foundation

struct JsonChartItem: Decodable {
    let columns: [[JsonValue]]
    let types: [String: String]
    let names: [String: String]
    let colors: [String: String]
}


struct JsonValue: Decodable {
    let string: String?
    let int: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.string = try? container.decode(String.self)
        self.int = try? container.decode(Int.self)
    }
}
