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
//        navigationItem.title = title
        chartsContainer?.charts.enumerated().forEach({ (index, chart) in
            let vc = storyboard!.instantiateViewController(withIdentifier: "ChartContainerViewController") as! ChartContainerViewController
            vc.chart = chart
            vc.textTitle = "Chart #\(index)"
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.view.frame = scrollView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.didMove(toParent: self)
        })
        colorsUpdate()
    }
    
    func colorsUpdate() {
        let colors = ColorTheme.current.colors
        view.backgroundColor = colors.mainBackground
        (children as? [ChartContainerViewController])?.forEach { $0.colors = colors }
        updateNavigationBar()
    }
    
    private func updateNavigationBar() {
        let theme = ColorTheme.current
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = theme == .light ? .default : .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme!.colors.lineText]
        navigationController?.navigationBar.barTintColor = theme?.colors.mainBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    @IBAction func change(_ sender: Any) {
        let theme = ColorTheme.current
        ColorTheme.current = theme == .light ? .dark : .light
        colorsUpdate()
    }
    
    private func updateFrames() {
        let size = (children as? [ChartContainerViewController])?.reduce(0, { (offset, vc) -> CGFloat in
            let height = vc.tableView.contentSize.height
            vc.view.frame = CGRect(x: 0, y: offset, width: scrollView.bounds.width, height: height)
            return offset + height
        })
        scrollView.contentSize.height = size ?? 0
    }

}
