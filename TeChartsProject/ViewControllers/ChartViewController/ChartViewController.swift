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
    
    @IBOutlet private weak var xAxisBaseLineView: UIView!
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
            chartView?.chart = chart
            updateYAxisLabels()
            updateXAxisLabels()
            overlayViewController?.view?.isHidden = true
        }
    }
    
    var colors: Colors? {
        didSet {
            colorsUpdate()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    private var overlayViewController: OverlayViewController!
    private var startTouchPoint: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chart = chart
        updateXAxisLabels()
        updateYAxisLabels()
        colorsUpdate()
    }
    
    private func colorsUpdate() {
        xAxisDataSource.colors = colors
        yAxisDataSource.colors = colors
        overlayViewController?.colors = colors
        backgroundView?.linesColor = colors?.chartLines ?? .lightGray
        xAxisBaseLineView?.backgroundColor = colors?.mainAxis
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OverlayViewController {
            overlayViewController = vc
            overlayViewController.colors = colors
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
        let list = (0...5).map { CGFloat($0) * step + start }.compactMap { value -> Int? in
//            let index = chart?.x[Int($0)]
            let index = Int(value)
            if index < (chart?.x.count ?? 0) {
                return chart?.x[index]
            }
            return nil
        }//.compactMap { $0 }
        
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
        startTouchPoint = touches.first?.location(in: chartView)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first  else { return }
        let point = touch.location(in: chartView)
        guard startTouchPoint?.equalTo(point) == true else { return }
        guard let chart = chart else { return }

        let index = Int((point.x / chartView.bounds.width) * CGFloat(chart.x.count))
        let lines = chart.lines.filter { $0.enabled }
        guard lines.count > 0 else { return }

        let overlayPoint = touch.location(in: overlayViewController.view)
        let xValue = chart.x[index]
        let dateStr = dateFormatter.string(from: Date(timeIntervalSince1970: Double(xValue) / 1000))
        let diff = overlayPoint.x - point.x
        overlayViewController.data = lines.map { (line) -> (CGPoint, HistoryItem) in
            let y = line.values[index]
            let temp = chartView.point(from: (x: xValue, y: y))
            let resultPoint = CGPoint(x: diff + temp.x, y: temp.y)
            let item = HistoryItem(
                title: line.name,
                value: String(line.values[index]),
                color: line.color
            )
            return (resultPoint, item)
        }
        overlayViewController.historyTitle = dateStr
        overlayViewController.view.isHidden = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTouchPoint = nil
    }
    
}
