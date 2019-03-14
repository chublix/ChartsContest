//
//  ChartView.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


public class ChartView: UIView {
    
    public var points: [CGPoint] = [] {
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
    
    private var chartsSubLayers: [CALayer] = []
    
    private var chartAxisTextLayers: [CATextLayer] = []
    
    private var chartSupplementLayers: [CALayer] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
