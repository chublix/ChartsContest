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
    
    @IBOutlet private weak var backgroundView: UIView!
//    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var chartViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var xAxisDataSource: XAxisCollectionViewDataSource!
    @IBOutlet private weak var yAxisDataSource: YAxisCollectionViewDataSource!
    
    var scale: Float = 1.0 {
        didSet {
            let newWidth = (maxContentWidth - scrollView.bounds.width) * CGFloat(scale)
//            chartView.frame.size.width = contentView.bounds.width + newWidth
            chartViewWidthConstraint.constant = newWidth
//            scrollView.contentSize.width = newWidth
        }
    }
    
    var chart: Chart? {
        didSet {
            chartView?.chartsData = chart
            updateYAxisLabels()
        }
    }
    
    private var maxContentWidth: CGFloat = 0
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xAxisDataSource.titles = ["feb 4", "feb 7", "feb 10", "feb 13"]
        updateYAxisLabels()
        chartSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backgroundLayer = BackgroundLayer()
        backgroundLayer.backgroundColor = UIColor.clear.cgColor
        backgroundLayer.linesColor = UIColor.lightGray
        backgroundLayer.linesCount = 6
        backgroundLayer.frame = scrollView.frame
        backgroundView.layer.addSublayer(backgroundLayer)
    }
    
    private func chartSetup() {
        chartView.chartsData = chart
        chartViewWidthConstraint.constant = (chartView.frame.height / 6) * CGFloat(chart?.x.count ?? 0)
        scrollView.contentSize.width = chartViewWidthConstraint.constant
        maxContentWidth = chartViewWidthConstraint.constant
    }
    
    private func updateXAxisLabels() {
        
    }
    
    private func updateYAxisLabels() {
        guard let lines = chart?.lines.filter({ $0.enabled }).map({ $0.values }).flatMap({ $0 }) else { return }
        guard let min = lines.min(), let max = lines.max() else { return }
        let diff = max - min
        let step = diff / 6
        let strings = (1...4).map { "\(step * $0 + min)" }
        yAxisDataSource.titles = (["\(min)"] + strings + ["\(max)"]).reversed()
    }
    
}
