//
//  ChartContainerViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


class ChartContainerViewController: UIViewController {

    private weak var chartViewController: ChartViewController! {
        didSet { chartViewController.chart = chart }
    }
    private weak var chartSliderViewController: ChartSliderViewController! {
        didSet {
            chartSliderViewController.delegate = self
            chartSliderViewController.chart = chart
        }
    }
    
    var chart: Chart?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartViewController {
            chartViewController = vc
        } else if let vc = segue.destination as? ChartSliderViewController {
            chartSliderViewController = vc
        }
    }
    
    @IBAction private func disableChart(_ sender: UIButton) {
        chartSliderViewController.chart.lines[0].enabled.toggle()
        chartViewController.chart?.lines[0].enabled.toggle()
    }

}


extension ChartContainerViewController: ChartSliderViewControllerDelegate {
    
    func chartSliderViewController(_ controller: ChartSliderViewController, changedMin min: Float, changedMax max: Float) {
        chartViewController.scale = 1 / (max - min)
        chartViewController.offset = min
    }
    
}
