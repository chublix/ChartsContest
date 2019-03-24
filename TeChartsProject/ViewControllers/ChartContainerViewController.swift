//
//  ChartContainerViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


class ChartContainerViewController: UITableViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableHeaderContentView: UIView!
    
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
    
    var textTitle: String?
    
    var colors: Colors? {
        didSet { colorsUpdate() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        titleLabel?.text = textTitle?.uppercased()
        colorsUpdate()
    }
    
    func colorsUpdate() {
        titleLabel.textColor = colors?.axisText
        tableHeaderContentView.backgroundColor = colors?.contentBackground
        chartViewController?.colors = colors
        chartSliderViewController.colors = colors
        tableView.separatorColor = colors?.tableSeparator
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartViewController {
            chartViewController = vc
            chartViewController.colors = ColorTheme.current.colors
        } else if let vc = segue.destination as? ChartSliderViewController {
            chartSliderViewController = vc
            chartSliderViewController.colors = ColorTheme.current.colors
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
        (cell as? ChartLineTableViewCell)?.setup(with: line, textColor: colors?.lineText)
        (cell as? ChartLineTableViewCell)?.backgroundColor = colors?.contentBackground
        cell.separatorInset.left = (indexPath.row + 1) == chart?.lines.count ? tableView.bounds.width : 48
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
