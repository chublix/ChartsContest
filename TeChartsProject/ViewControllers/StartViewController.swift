//
//  StartViewController.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private lazy var chartsContainer: ChartsContainer? = {
        let url = Bundle.main.url(forResource: "chart_data", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else { return nil }
        return ChartsContainer(from: data)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        chartsContainer?.charts.forEach({ (chart) in
            let vc = storyboard!.instantiateViewController(withIdentifier: "ChartContainerViewController") as! ChartContainerViewController
            vc.chart = chart
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.view.frame = scrollView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.didMove(toParent: self)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    private func updateFrames() {
//        (children as? [ChartContainerViewController])?.forEach({ (vc) in
//            vc.view.frame =
//        })
        
        let size = (children as? [ChartContainerViewController])?.reduce(0, { (offset, vc) -> CGFloat in
            let height = vc.tableView.contentSize.height//vc.view.bounds.height
            vc.view.frame = CGRect(x: 0, y: offset, width: scrollView.bounds.width, height: height)
            return offset + height
        })
        scrollView.contentSize.height = size ?? 0
    }

}


