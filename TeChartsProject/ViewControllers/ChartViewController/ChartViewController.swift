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
    
    @IBOutlet private weak var backgroundView: BackgroundView!
    @IBOutlet private weak var chartViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var xAxisDataSource: XAxisCollectionViewDataSource!
    @IBOutlet private weak var yAxisDataSource: YAxisCollectionViewDataSource!
    
    var offset: Float = 0.0 {
        didSet {
            overlayViewController.view.isHidden = true
            let x = CGFloat(offset) * scrollView.contentSize.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
            updateXAxisLabels()
        }
    }
    
    var scale: Float = 6.0 {
        didSet {
            overlayViewController.view.isHidden = true
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
    
    private var overlayViewController: OverlayViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chartsData = chart
        updateXAxisLabels()
        updateYAxisLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OverlayViewController {
            overlayViewController = vc
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chartViewWidthConstraint.constant = scrollView.bounds.width * 6
    }
    
    private func updateXAxisLabels() {
        let count = CGFloat(chart?.x.count ?? 0)
        let step = count / CGFloat(scale * 6)
        let start = CGFloat(offset) * count
        let list = (0...5).map { CGFloat($0) * step + start }.map { chart?.x[Int($0)] }.compactMap { $0 }
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


extension ChartViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let chart = chart else { return }
        overlayViewController.view.isHidden = false
        let point = touch.location(in: chartView)
        let overlayPoint = touch.location(in: overlayViewController.view)
        
        let index = Int((point.x / chartView.bounds.width) * CGFloat(chart.x.count))
        let value = chart.x[index]
        let str = dateFormatter.string(from: Date(timeIntervalSince1970: Double(value) / 1000))
        let yValues = chart.lines.map { $0.values[index] }
        let points = yValues.map { chartView.point(from: (x: value, y: $0)) }
        let result = points.map { CGPoint(x: overlayPoint.x - (point.x - $0.x), y: $0.y) }
        overlayViewController.data = result.enumerated().map({ (offset, element) -> (CGPoint, HistoryItem) in
            let line = chart.lines[offset]
            let item = HistoryItem(
                title: line.name,
                value: String(line.values[index]),
                color: line.color
            )
            return (element, item)
        })
        overlayViewController.historyTitle = str
    }
    
}
