//
//  StartViewController.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet { tableView.tableFooterView = UIView() }
    }
    
    private lazy var chartsContainer: ChartsContainer? = {
        let url = Bundle.main.url(forResource: "chart_data", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else { return nil }
        return ChartsContainer(from: data)
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChartContainerViewController {
            vc.chart = sender as? Chart
        }
    }

}

extension StartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartsContainer?.charts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
}

extension StartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "Chart #\(indexPath.row)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chart = chartsContainer?.charts[indexPath.row]
        performSegue(withIdentifier: "showChart", sender: chart)
    }
    
}
