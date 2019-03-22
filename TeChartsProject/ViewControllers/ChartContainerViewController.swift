//
//  ChartContainerViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


class ChartContainerViewController: UIViewController {

    @IBOutlet private weak var sliderContentView: UIView!
    
    private weak var chartViewController: ChartViewController!
    private weak var chartView: ChartView!
    
    var chart: Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartViewController {
            vc.chart = chart
            chartViewController = vc
        }
    }
    
    private func setup() {
        let chartView = ChartView(frame: sliderContentView.bounds)
        chartView.lineWidth = 1
        chartView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        chartView.chartsData = chart
        sliderContentView.addSubview(chartView)
        self.chartView = chartView
    }
    
    @IBAction private func disableChart(_ sender: UIButton) {
        chartView.chartsData?.lines[0].enabled.toggle()
        chartViewController.chart?.lines[0].enabled.toggle()
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        chartViewController.scale = sender.value
    }

}

