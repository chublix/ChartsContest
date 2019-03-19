//
//  ChartTextsLayer.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/19/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//


internal class ChartTextsLayer: CALayer {
    
    var strings: [String] = [] {
        didSet {
            update()
        }
    }
    
    var font: UIFont?
    
    var color: UIColor?
    
    var axis: Axis = .y
    
    private var textLayers: [CATextLayer]? {
        get { return sublayers as? [CATextLayer] }
        set { sublayers = textLayers }
    }
    
    private func createSublayers() -> [CATextLayer] {
        let step = (axis == .y ? bounds.height : bounds.width) / CGFloat(strings.count)
        return (0..<strings.count).map { (index) -> CATextLayer in
            let layer = CATextLayer()
            layer.alignmentMode = axis == .y ? .left : .center
            let offset = step * CGFloat(index)
            if axis == .y {
                layer.frame = CGRect(x: 0, y: offset, width: bounds.width, height: step)
            } else {
                layer.frame = CGRect(x: offset, y: 0, width: step, height: bounds.height)
            }
            return layer
        }
    }
    
    private func update() {
        if sublayers?.count != strings.count {
            textLayers = createSublayers()
        }
        textLayers?.enumerated().forEach { (index, layer) in
            layer.string = strings[index]
            layer.font = font
            layer.foregroundColor = color?.cgColor
        }
    }
    
}

extension ChartTextsLayer {
    
    enum Axis {
        case x
        case y
    }
    
}
