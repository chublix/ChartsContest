//
//  ViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


struct RawChartItem: Decodable {
    let columns: [[Value]]
    let types: [String: String]
    let names: [String: String]
    let colors: [String: String]
}


struct Value: Decodable {
    let string: String?
    let int: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.string = try? container.decode(String.self)
        self.int = try? container.decode(Int.self)
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func createChartItems(data: Data) -> [ChartItem] {
        guard let rawItems = try? JSONDecoder().decode([RawChartItem].self, from: data) else { return [] }
        return rawItems.map { (item) -> ChartItem in
            let columns = item.columns.map { column -> ChartColumn? in
                guard let id = column.first?.string else { return nil }
                guard let typeID = item.types[id], let type = ChartColumn.ColumnType(rawValue: typeID) else { return nil }
                let values = column.compactMap { $0.int }
                let color = UIColor(hex: item.colors[id])
                return ChartColumn(name: item.names[id], values: values, type: type, color: color)
            }
            return ChartItem(columns: columns.compactMap { $0 })
        }
    }
    
//    private func drawChartView() {
//        let url = Bundle.main.url(forResource: "chart_data", withExtension: "json")
//        guard let data = try? Data(contentsOf: url!) else { return }
//        let items = createChartItems(data: data)
//    }
    
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {

    }

}

