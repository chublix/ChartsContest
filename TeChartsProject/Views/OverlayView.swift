//
//  OverlayView.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/23/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class OverlayView: UIView {

    @IBInspectable var lineColor: UIColor = .lightGray {
        didSet { lineLayer.strokeColor = lineColor.cgColor }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1.0 {
        didSet { lineLayer.lineWidth = lineWidth }
    }
    
    @IBInspectable var pointFillColor: UIColor = .white {
        didSet { pointsLayers.forEach { $0.fillColor = pointFillColor.cgColor} }
    }
    
    override var frame: CGRect {
        didSet { updateFrames() }
    }
    
    override var bounds: CGRect {
        didSet { updateFrames() }
    }
    
    var points: [(CGPoint, UIColor)] = [] {
        didSet { update() }
    }
    
    private lazy var lineLayer = CAShapeLayer()
    private var pointsLayers: [CAShapeLayer] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperlayer() }
            pointsLayers.forEach { layer.addSublayer($0) }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(lineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(lineLayer)
    }
    
    private func updateFrames() {
        lineLayer.frame = bounds
        pointsLayers.forEach { $0.frame = bounds }
    }
    
    private func update() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: points[0].0.x, y: 0))
        path.addLine(to: CGPoint(x: points[0].0.x, y: bounds.height))
        lineLayer.path = path.cgPath
        pointsLayers = points.map { _ in return CAShapeLayer() }
        zip(points, pointsLayers).forEach { item in
            let ((point, color), pointLayer) = item
            let path = UIBezierPath(arcCenter: point, radius: 3.5, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            pointLayer.strokeColor = color.cgColor
            pointLayer.lineWidth = 2
            pointLayer.fillColor = pointFillColor.cgColor
            pointLayer.path = path.cgPath
        }
    }

}
