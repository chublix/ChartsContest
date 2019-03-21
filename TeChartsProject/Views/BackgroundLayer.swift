//
//  BackgroundLayer.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/17/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

public class BackgroundLayer: CALayer {

    public var linesCount: Int = 4
    public var linesColor: UIColor = .white {
        didSet {
            linesLayer.strokeColor = linesColor.cgColor
        }
    }
    public var linesWidth: CGFloat = 1.0 {
        didSet {
            linesLayer.lineWidth = linesWidth
        }
    }
    
    private var linesLayer: CAShapeLayer!
    
    public override var frame: CGRect {
        get { return super.frame }
        set {
            super.frame = newValue
            update()
        }
    }
    
    public override init() {
        super.init()
        linesLayer = CAShapeLayer()
        addSublayer(linesLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        linesLayer.frame = bounds
        linesLayer.strokeColor = linesColor.cgColor
        linesLayer.lineWidth = linesWidth
        let step = bounds.height / CGFloat(linesCount)
        let bezierPath = UIBezierPath()
        for i in 1...linesCount {
            let offset = CGFloat(i) * step
            bezierPath.move(to: CGPoint(x: 0, y: offset))
            bezierPath.addLine(to: CGPoint(x: bounds.width, y: offset))
        }
        linesLayer.path = bezierPath.cgPath
    }
    
}
