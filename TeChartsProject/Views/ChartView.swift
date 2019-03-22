//
//  ChartView.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/21/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartView: UIView {

    var chartsData: Chart? {
        didSet {
            update()
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 0
    
    override var frame: CGRect {
        didSet { update() }
    }
    
    override var bounds: CGRect {
        didSet { update() }
    }
    
    private var firstX: Int = 0
    private var lastX: Int = 0
    private var greatestY: Int = 0
    
    private var chartsSublayers: [CAShapeLayer]? {
        get { return layer.sublayers as? [CAShapeLayer] }
        set { layer.sublayers = newValue }
    }
    
    private func createSubLayers(for lines: [Line]?) -> [CAShapeLayer]? {
        return lines?.map { _ -> CAShapeLayer in
            let shape = CAShapeLayer()
            shape.fillColor = UIColor.clear.cgColor
            return shape
        }
    }
    
    private func point(from values: (x: Int, y: Int)) -> CGPoint {
        let x: CGFloat = ((CGFloat(values.x - firstX)) * bounds.width) / CGFloat(lastX - firstX)
        let y: CGFloat = (bounds.height - (CGFloat(values.y) * bounds.height) / CGFloat(greatestY))
        return CGPoint(x: x, y: y)
    }
    
    private func updateChartSublayers(for lines: [Line]?) {
        zip(chartsSublayers ?? [], lines ?? []).forEach { (item) in
            let (layer, line) = item
            layer.lineWidth = lineWidth
            layer.strokeColor = line.color.cgColor
            layer.frame = bounds
            layer.path = createPath(for: line)?.cgPath
        }
    }
    
    private func createPath(for line: Line) -> UIBezierPath? {
        guard let xValues = chartsData?.x else { return nil }
        let sequence = Array(zip(xValues, line.values))
        let first = sequence[0]
        let path = UIBezierPath()
        path.move(to: point(from: first))
        sequence.dropFirst().forEach { (item) in
            path.addLine(to: point(from: item))
        }
        return path
    }
    
    private func update() {
        let lines = chartsData?.lines.filter { $0.enabled }
        greatestY = lines?.map { $0.values }.flatMap { $0 }.max() ?? 0
        firstX = chartsData?.x.first ?? 0
        lastX = chartsData?.x.last ?? 0
        
        if chartsSublayers?.count != lines?.count {
            chartsSublayers = createSubLayers(for: lines)
        }
        updateChartSublayers(for: lines)
    }
    
}
