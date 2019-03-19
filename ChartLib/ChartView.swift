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
    
    private lazy var chartsContainerLayer: CALayer = {
        let layer = CALayer()
        layer.transform = CATransform3DMakeRotation(.pi, 1, 0, 0)
        return layer
    }()
    
    private lazy var backgroundLayer: BackgroundLayer = BackgroundLayer()
    
    private var chartsSubLayers: [CALayer] = []
    
    private var chartAxisTextLayers: [CATextLayer] = []
    
    private var chartSupplementLayers: [CALayer] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(contentLayer)
        contentLayer.backgroundColor = UIColor.clear.cgColor
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        contentLayer.addSublayer(backgroundLayer)
        contentLayer.addSublayer(chartsContainerLayer)
        chartsContainerLayer.backgroundColor = UIColor.clear.cgColor
        
        redraw()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func redraw() {
        let rect = layer.bounds
        contentLayer.frame = rect
        contentLayer.contentsRect = rect
        contentLayer.contentsRect.size.width = rect.width * 7
        
        chartsContainerLayer.frame = contentLayer.contentsRect
        backgroundLayer.frame = contentLayer.contentsRect
    }

}
