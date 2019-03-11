//
//  ChartView.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit


public class ChartView: UIView {

    private lazy var scrollLayer = CAScrollLayer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        scrollLayer.frame = CGRect(origin: .zero, size: CGSize(width: frame.width * 3, height: frame.height))
//        scrollLayer.scrollMode = .horizontally
//        contentSize = CGSize(width: frame.width * 3, height: frame.height)
//        bounces = false
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    private func drawBackground(ctx: CGContext?) {
//        let step = bounds.height / 5
//        ctx?.setLineWidth(0.5)
//        ctx?.setStrokeColor(UIColor.darkGray.cgColor)
//        for i in 1...4 {
//            let offset = CGFloat(i) * step
//            ctx?.strokeLineSegments(between: [CGPoint(x: 0, y: offset), CGPoint(x: bounds.width, y: offset)])
////            ctx?.move(to:CGPoint(x: 0, y: offset))
////            ctx?.addLine(to: CGPoint(x: bounds.width, y: offset))
//        }
//    }
//

    
    private func drawBackground(ctx: CGContext?) {
        ctx?.saveGState()
        let step = bounds.height / 5
        ctx?.setStrokeColor(UIColor.darkGray.cgColor)
        ctx?.beginPath()
        for i in 1...4 {
            let offset = CGFloat(i) * step
            ctx?.setLineWidth(0.1)
            ctx?.move(to:CGPoint(x: 0, y: offset))
            ctx?.addLine(to: CGPoint(x: bounds.width, y: offset))
        }
        ctx?.closePath()
        ctx?.drawPath(using: .stroke)
        ctx?.restoreGState()
    }
    


    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.clear(rect)
        drawBackground(ctx: ctx)
//        UIGraphicsEndImageContext()
    }

}
