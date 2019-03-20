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
    
    private var chartAxisTextLayers: [ChartTextsLayer] = []
    
    private var chartSupplementLayers: [CALayer] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createAxisTextLayers()
        
        layer.addSublayer(contentLayer)
        contentLayer.backgroundColor = UIColor.clear.cgColor
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        
        chartAxisTextLayers.forEach { layer.addSublayer($0); $0.zPosition = 9 }
        
        contentLayer.addSublayer(backgroundLayer)
        contentLayer.addSublayer(chartsContainerLayer)
        chartsContainerLayer.backgroundColor = UIColor.clear.cgColor
        
        redraw()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createAxisTextLayers() {
        let horizonatal = ChartTextsLayer()
        horizonatal.frame = CGRect(x: 0, y: frame.height - 30, width: frame.width, height: 30)
        horizonatal.color = .blue
        horizonatal.axis = .horizontal
        horizonatal.strings = ["12, 16, 20, 24"]
        
        let vertical = ChartTextsLayer()
        vertical.frame = CGRect(x: 0, y: 0, width: 50, height: frame.height)
        vertical.color = .red
        vertical.axis = .vertical
        vertical.strings = ["80, 60, 40, 20, 0"]
        
        chartAxisTextLayers = [horizonatal, vertical]
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
