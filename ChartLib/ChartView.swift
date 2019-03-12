//
//  ChartView.swift
//  ChartLib
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

public class ScrollLayer: CAScrollLayer {
    
    public override func display() {
        super.display()
        debugPrint("display")
    }
    
}

public class ChartView: UIScrollView {
    
    private lazy var contentView = ChartContentView()
    public var points: [CGPoint] = [] {
        didSet {
            contentView.points = points
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        let size = CGSize(width: frame.width * 10, height: frame.height)
        contentView.frame = CGRect(origin: .zero, size: size)
        contentView.backgroundColor = .lightGray
        contentSize = size
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


public class ChartContentView: UIView {
    
    public var points: [CGPoint] = [] {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        layer.transform = CATransform3DMakeRotation(.pi, 1, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawBackground(ctx: CGContext?) {
        ctx?.saveGState()
        let step = bounds.height / 6
        ctx?.setStrokeColor(UIColor.white.cgColor)
        ctx?.setLineWidth(0.5)
        ctx?.setShadow(offset: .zero, blur: 0.0)
        ctx?.beginPath()
        for i in 1...5 {
            let offset = CGFloat(i) * step
            ctx?.move(to:CGPoint(x: 0, y: offset))
            ctx?.addLine(to: CGPoint(x: bounds.width, y: offset))
        }
        ctx?.closePath()
        ctx?.drawPath(using: .stroke)
        ctx?.restoreGState()
    }
    
    private func drawChart(ctx: CGContext?) {
        guard points.count > 0 else { return }
        
        ctx?.saveGState()
        ctx?.setStrokeColor(UIColor.blue.cgColor)
        ctx?.setLineWidth(1)
        ctx?.beginPath()
        let preparedPoints = points.map { CGPoint(x: $0.x, y: $0.y) }
        ctx?.addLines(between: preparedPoints)
        ctx?.move(to: preparedPoints.last!)
        ctx?.closePath()
        ctx?.drawPath(using: .stroke)
        ctx?.restoreGState()
    }
    
    private func drawCircles(ctx: CGContext?) {
        guard points.count > 0 else { return }
        
        ctx?.saveGState()
        
        ctx?.beginPath()
        ctx?.setFillColor(UIColor.lightGray.cgColor)
        ctx?.setStrokeColor(UIColor.red.cgColor)
        let rect = CGRect(x: 0, y: 0, width: 5, height: 5)
        var neededPoints = points
        neededPoints.removeFirst()
        neededPoints.removeLast()
        neededPoints.forEach { pair in
            let temp = rect.offsetBy(dx: pair.x - 2.5, dy: pair.y - 2.5)
            ctx?.addEllipse(in: temp)
        }
        ctx?.closePath()
        
        ctx?.drawPath(using: .fillStroke)
        ctx?.restoreGState()
    }

    private func drawText(ctx: CGContext?) {
        ctx?.saveGState()
        
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 20, y: 20, width: 90, height: 20)
        textLayer.font = UIFont.systemFont(ofSize: 14.0)
        textLayer.fontSize = 14
        textLayer.foregroundColor = UIColor.green.cgColor
        textLayer.string = "Test string"
//        ctx?.move(to: CGPoint(x: 50, y: 50))
        textLayer.render(in: ctx!)
//        let str = NSAttributedString(string: "Test string", attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.green])
//        str.draw(at: CGPoint(x: 20, y: 20))
        
        ctx?.restoreGState()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.clear(rect)
//        ctx?.setFillColor(UIColor.lightGray.cgColor)
//        ctx?.fill(rect)
        drawBackground(ctx: ctx)
        drawChart(ctx: ctx)
        drawCircles(ctx: ctx)
        drawText(ctx: ctx)
    }

}
