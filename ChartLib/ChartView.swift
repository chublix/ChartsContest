//
//  ChartView.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


public class ChartView: UIView {
    
    public var chartItems: [ChartItem] = [] {
        didSet {
            
        }
    }
    
    private lazy var contentLayer: CAScrollLayer = {
        let layer = CAScrollLayer()
        layer.scrollMode = .horizontally
        return layer
    }()
    
    private lazy var chartsLayer: CALayer = {
        let layer = CALayer()
        layer.transform = CATransform3DMakeRotation(.pi, 1, 0, 0)
        return layer
    }()
    
    private var axisLayers: [CALayer] = []
    
    private var chartsSubLayers: [CALayer] = []
    
    private var chartAxisTextLayers: [CATextLayer] = []
    
    private var chartSupplementLayers: [CALayer] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(contentLayer)
        contentLayer.backgroundColor = UIColor.lightGray.cgColor
        setupAxis()
        axisLayers.forEach { contentLayer.addSublayer($0) }
        
        contentLayer.addSublayer(chartsLayer)
        chartsLayer.backgroundColor = UIColor.clear.cgColor
        
        
        
        redraw()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAxis() {
        let step = bounds.height / 6
        for i in 1...5 {
            let offset = CGFloat(i) * step
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: offset, width: bounds.width, height: 1)
            layer.backgroundColor = UIColor.white.cgColor
            axisLayers.append(layer)
        }
    }
    
    private func redraw() {
        let rect = layer.bounds
        contentLayer.frame = rect
        contentLayer.contentsRect = rect
        contentLayer.contentsRect.size.width = rect.width * 7
        
        chartsLayer.frame = contentLayer.contentsRect
    }

}
