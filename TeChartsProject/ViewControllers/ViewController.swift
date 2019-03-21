//
//  ViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit





class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func loadCharts(from data: Data) -> ChartsContainer? {
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
        return ChartsContainer(charts: charts)
    }
    
//    private func drawChartView() {
//        let url = Bundle.main.url(forResource: "chart_data", withExtension: "json")
//        guard let data = try? Data(contentsOf: url!) else { return }
//        let items = createChartItems(data: data)
//    }
    
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {

    }

}

