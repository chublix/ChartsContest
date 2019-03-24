//
//  ChartView.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/21/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartView: UIView {

    var chart: Chart? {
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
    
//    private var firstX: Int = 0
//    private var lastX: Int = 0
//    private var greatestY: Int = 0

    private var minX: Int = 0
    private var sizeX: Int = 0
    private var minY: Int = 0
    private var sizeY: Int = 0
    
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
        guard let xValues = chart?.x else { return nil }
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
        guard let chart = chart else { return }
        let lines = chart.lines.filter { $0.enabled }

        let allYValues = lines.map { $0.values }.flatMap { $0 }
        minY = allYValues.min() ?? 0
        sizeY = (allYValues.max() ?? 0) - minY
        minX = chart.x.first ?? 0
        sizeX = (chart.x.last ?? 0) - minX
        
        if chartsSublayers?.count != lines.count {
            chartsSublayers = createSubLayers(for: lines)
        }
        updateChartSublayers(for: lines)
    }
    
    func point(from values: (x: Int, y: Int)) -> CGPoint {
        let x: CGFloat = ((CGFloat(values.x - minX)) * bounds.width) / CGFloat(sizeX)
        let y: CGFloat = (bounds.height - (CGFloat(values.y - minY) * bounds.height) / CGFloat(sizeY))
        return CGPoint(x: x, y: y)
    }
    
}
