//
//  BackgroundView.swift
//  TeChartsProject
//
//  Created by Elena Chekhova on 3/23/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    @IBInspectable var linesCount: Int = 4 {
        didSet { update() }
    }
    
    @IBInspectable var linesColor: UIColor = .white {
        didSet { linesLayer.strokeColor = linesColor.cgColor }
    }
    
    @IBInspectable var linesWidth: CGFloat = 1.0 {
        didSet { linesLayer.lineWidth = linesWidth }
    }
    
    private lazy var linesLayer = CAShapeLayer()
    
    override var frame: CGRect {
        didSet { update() }
    }
    
    override var bounds: CGRect {
        didSet { update() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(linesLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(linesLayer)
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
