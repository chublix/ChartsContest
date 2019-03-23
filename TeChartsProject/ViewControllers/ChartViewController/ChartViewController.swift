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
    @IBOutlet private weak var chartViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var xAxisDataSource: XAxisCollectionViewDataSource!
    @IBOutlet private weak var yAxisDataSource: YAxisCollectionViewDataSource!
    
    var offset: Float = 0.0 {
        didSet {
            let x = CGFloat(offset) * scrollView.contentSize.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
            updateXAxisLabels()
        }
    }
    
    var scale: Float = 5.0 {
        didSet {
            let newWidth = scrollView.bounds.width * CGFloat(scale)
            chartViewWidthConstraint.constant = newWidth
        }
    }
    
    var chart: Chart? {
        didSet {
            chartView?.chartsData = chart
            updateYAxisLabels()
            updateXAxisLabels()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chartsData = chart
        updateXAxisLabels()
        updateYAxisLabels()
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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        chartViewWidthConstraint.constant = scrollView.bounds.width * 5
    }
    
    private func updateXAxisLabels() {
        let count = CGFloat(chart?.x.count ?? 0)
        let step = count / CGFloat(scale * 5)
        let start = CGFloat(offset) * count
        let list = (0...4).map { CGFloat($0) * step + start }.map { chart?.x[Int($0)] }.compactMap { $0 }
        let titles = list.map { dateFormatter.string(from: Date(timeIntervalSince1970: Double($0) / 1000)) }
        xAxisDataSource.titles = titles
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
