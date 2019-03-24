//
//  OverlayViewController.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var historyView: UIView!
    @IBOutlet private weak var collectionViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var historyDataSource: HistoryDataSource!
    @IBOutlet private weak var historyOffsetViewConstraint: NSLayoutConstraint!
    
    @IBInspectable var lineColor: UIColor = .lightGray {
        didSet { lineLayer.strokeColor = lineColor.cgColor }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1.0 {
        didSet { lineLayer.lineWidth = lineWidth }
    }
    
    @IBInspectable var pointFillColor: UIColor = .white {
        didSet { pointsLayers.forEach { $0.fillColor = pointFillColor.cgColor} }
    }
    
    var data: [(CGPoint, HistoryItem)] = [] {
        didSet { update() }
    }
    
    var historyTitle: String = "" {
        didSet { titleLabel?.text = historyTitle }
    }
    
    var colors: Colors? {
        didSet { colorsUpdate() }
    }
    
    private lazy var lineLayer = CAShapeLayer()
    private var pointsLayers: [CAShapeLayer] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperlayer() }
            pointsLayers.forEach { view.layer.addSublayer($0) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyView.layer.cornerRadius = 5
        historyView.layer.zPosition = 10
        view.layer.addSublayer(lineLayer)
        colorsUpdate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    private func colorsUpdate() {
        historyView?.backgroundColor = colors?.mainBackground
        titleLabel?.textColor = colors?.historyTitle
        lineColor = colors?.mainAxis ?? .clear
        pointFillColor = colors?.contentBackground ?? .clear
    }
    
    private func updateFrames() {
        lineLayer.frame = view.bounds
        pointsLayers.forEach { $0.frame = view.bounds }
    }
    
    private func update() {
        let x = data[0].0.x
        if x < 5 || x > lineLayer.bounds.width - 5 {
            view.isHidden = true
            return
        }
        
        historyDataSource.items = data.map { $0.1 }
        updateHistoryViewFrame(for: x)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: view.bounds.height))
        lineLayer.path = path.cgPath
        pointsLayers = data.map { _ in return CAShapeLayer() }
        zip(data, pointsLayers).forEach { item in
            let ((point, historyItem), pointLayer) = item
            let path = UIBezierPath(arcCenter: point, radius: 3.5, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            pointLayer.strokeColor = historyItem.color.cgColor
            pointLayer.lineWidth = 2
            pointLayer.fillColor = pointFillColor.cgColor
            pointLayer.path = path.cgPath
        }
    }
    
    private func updateHistoryViewFrame(for x: CGFloat) {
        let contentWidth = historyDataSource.contentWidth
        collectionViewWidthConstraint.constant = contentWidth > 50 ? contentWidth : 50
        let halfWidth = historyView.bounds.width / 2
        let maxOffset = view.bounds.width - historyView.bounds.width
        var offset = x - halfWidth
        if offset > maxOffset {
            offset = maxOffset
        } else if offset < halfWidth {
            offset = 0
        }
        historyOffsetViewConstraint.constant = offset
    }

}
