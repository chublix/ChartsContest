//
//  ViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet private weak var sliderContentView: UIView!
    
    private weak var chartViewController: ChartViewController!
    private weak var chartView: ChartView!
    
    private lazy var chartsContainer: ChartsContainer? = {
        let url = Bundle.main.url(forResource: "chart_data", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else { return nil }
        return loadCharts(from: data)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartViewController {
            vc.chart = chartsContainer?.charts[4]
            chartViewController = vc
        }
    }
    
    private func setup() {
        let chartView = ChartView(frame: sliderContentView.bounds)
        chartView.lineWidth = 1
        chartView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        chartView.chartsData = chartsContainer?.charts[4]
        sliderContentView.addSubview(chartView)
        self.chartView = chartView
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
    
    @IBAction private func disableChart(_ sender: UIButton) {
        chartView.chartsData?.lines[0].enabled.toggle()
        chartViewController.chart?.lines[0].enabled.toggle()
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        chartViewController.scale = sender.value
    }

}

