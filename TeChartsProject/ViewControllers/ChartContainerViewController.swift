//
//  ChartContainerViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


class ChartContainerViewController: UITableViewController {

    private weak var chartViewController: ChartViewController! {
        didSet { chartViewController.chart = chart }
    }
    private weak var chartSliderViewController: ChartSliderViewController! {
        didSet {
            chartSliderViewController.delegate = self
            chartSliderViewController.chart = chart
        }
    }
    
    var chart: Chart? {
        didSet {
            chartSliderViewController?.chart = chart
            chartViewController?.chart = chart
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartViewController {
            chartViewController = vc
        } else if let vc = segue.destination as? ChartSliderViewController {
            chartSliderViewController = vc
        }
    }

}


extension ChartContainerViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chart?.lines.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ChartLineTableViewCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let line = chart?.lines[indexPath.row] else { return }
        (cell as? ChartLineTableViewCell)?.setup(with: line)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chart?.lines[indexPath.row].enabled.toggle()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension ChartContainerViewController: ChartSliderViewControllerDelegate {
    
    func chartSliderViewController(_ controller: ChartSliderViewController, changedMin min: Float, changedMax max: Float) {
        chartViewController.scale = 1 / (max - min)
        chartViewController.offset = min
    }
    
}
