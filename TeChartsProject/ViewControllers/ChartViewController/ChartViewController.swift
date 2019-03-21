//
//  ChartViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/20/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet private weak var xAxisCollectionView: UICollectionView!
    @IBOutlet private weak var yAxisCollectionView: UICollectionView!
    
    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var xAxisDataSource: XAxisCollectionViewDataSource!
    @IBOutlet private weak var yAxisDataSource: YAxisCollectionViewDataSource!
    
    var scale: Float = 1.0 {
        didSet {
            let newWidth = (maxContentWidth - contentView.bounds.width) * CGFloat(scale)
            chartView.frame.size.width = contentView.bounds.width + newWidth
            scrollView.contentSize = chartView.frame.size
        }
    }
    
    var chart: Chart? {
        didSet {
            chartView?.chartsData = chart
        }
    }
    
    private var maxContentWidth: CGFloat = 0
    private weak var scrollView: UIScrollView!
    private weak var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xAxisDataSource.titles = ["feb 4", "feb 7", "feb 10", "feb 13"]
        yAxisDataSource.titles = ["0", "10", "20", "30", "40", "50"].reversed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backgroundLayer = BackgroundLayer()
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        backgroundLayer.linesColor = UIColor.lightGray
        backgroundLayer.linesCount = 6
        backgroundLayer.frame = contentView.frame
        contentView.layer.addSublayer(backgroundLayer)
        chartSetup()
    }
    
    private func chartSetup() {
        let chartView = ChartView(frame: contentView.bounds)
        chartView.frame.size.width = (chartView.frame.height / 6) * CGFloat(chart?.x.count ?? 0)
        chartView.lineWidth = 2
        
        let scrollView = UIScrollView(frame: contentView.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = chartView.bounds.size
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(chartView)
        chartView.chartsData = chart
        
        self.maxContentWidth = chartView.frame.size.width
        self.scrollView = scrollView
        self.chartView = chartView
    }
    
}
