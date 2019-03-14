//
//  ViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit
import ChartLib

struct Point: Decodable {
    let x: CGFloat
    let y: CGFloat
}

class ViewController: UIViewController {

    private var scrollLayer: CAScrollLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        drawChartView()
//        drawLayer()
        drawScroll()
    }
    
    private func drawChartView() {
        var points: [CGPoint] = []
        let url = Bundle.main.url(forResource: "points1", withExtension: "json")
        if let data = try? Data(contentsOf: url!), let result = try? JSONDecoder().decode([Point].self, from: data) {
            points = result.map { CGPoint(x: $0.x, y: $0.y) }
        }
        
        let width = view.bounds.width - 20
        let chartView = ChartView(frame: CGRect(x: 10, y: 50, width: width, height: width * 0.66))
        chartView.points = points
        chartView.backgroundColor = UIColor(hex: 0xf1f1f1)
        view.addSubview(chartView)
    }
    
    private func drawLayer() {
        
        let rawPoints: [(CGFloat, CGFloat)] = [
            (10,10), (25, 55), (32, 85), (57, 45), (68, 65), (85, 120),
            (95, 150), (108,115), (125, 160), (135, 180), (155, 173), (170, 110), (178, 115),
            (190, 150), (203,135), (215, 80), (230, 88), (250, 123), (260, 130), (272, 125),
            (280, 135), (290,40), (300, 75)
        ]
        let points = rawPoints.map { CGPoint(x: $0.0, y: $0.1) }
        
        let width = view.bounds.width - 20
        let background = CALayer()
        background.frame = CGRect(x: 10, y: 300, width: width, height: width * 0.666)
        background.backgroundColor = UIColor.lightGray.cgColor
        
        let chartLayer = CAShapeLayer()
        chartLayer.frame = background.bounds
        chartLayer.strokeColor = UIColor.yellow.cgColor
        chartLayer.lineWidth = 2
        chartLayer.fillColor = UIColor.clear.cgColor
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        points.forEach { point in
            bezierPath.addLine(to: point)
        }
        chartLayer.path = bezierPath.cgPath
        
        let pointsLayer = CAShapeLayer()
        pointsLayer.frame = background.bounds
        pointsLayer.strokeColor = UIColor.green.cgColor
        pointsLayer.lineWidth = 1
        pointsLayer.fillColor = UIColor.green.cgColor
        
        let pointBezierPath = UIBezierPath()
        pointBezierPath.move(to: .zero)
        points.forEach { point in
            pointBezierPath.move(to: point)
            pointBezierPath.addArc(withCenter: point, radius: 2.5, startAngle: 0, endAngle: .pi * 2.0, clockwise: true)
        }
        pointsLayer.path = pointBezierPath.cgPath
        
        view.layer.addSublayer(background)
        background.addSublayer(chartLayer)
        background.addSublayer(pointsLayer)
    }
    
    private func drawScroll() {
        let width = view.bounds.width - 20
//        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 300, width: width, height: width * 0.666))
//        let size = CGSize(width: width * 10, height: scrollView.frame.height)
//        scrollView.contentSize = size
        
        scrollLayer = CAScrollLayer()
        scrollLayer.frame = CGRect(x: 10, y: 300, width: width, height: width * 0.666)
        scrollLayer.contentsRect = CGRect(x: 0, y: 0, width: 2400, height: width * 0.666)
        scrollLayer.backgroundColor = UIColor.lightGray.cgColor
        
//        let contentView = UIView(frame: CGRect(origin: .zero, size: size))
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        
        var points: [CGPoint] = []
        let url = Bundle.main.url(forResource: "points1", withExtension: "json")
        if let data = try? Data(contentsOf: url!), let result = try? JSONDecoder().decode([Point].self, from: data) {
            points = result.map { CGPoint(x: $0.x, y: $0.y) }
        }
        
        let chartLayer = CAShapeLayer()
        chartLayer.frame = scrollLayer.contentsRect//contentView.bounds
        chartLayer.strokeColor = UIColor.yellow.cgColor
        chartLayer.lineWidth = 1
        chartLayer.fillColor = UIColor.clear.cgColor
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: points[0])
        points.forEach { point in
            bezierPath.addLine(to: point)
        }
        chartLayer.path = bezierPath.cgPath
        
        let pointsLayer = CAShapeLayer()
        pointsLayer.frame = chartLayer.frame
        pointsLayer.strokeColor = UIColor.green.cgColor
        pointsLayer.lineWidth = 1
        pointsLayer.fillColor = UIColor.green.cgColor
        
        let pointBezierPath = UIBezierPath()
        pointBezierPath.move(to: .zero)
        points.forEach { point in
            pointBezierPath.move(to: point)
            pointBezierPath.addArc(withCenter: point, radius: 2.5, startAngle: 0, endAngle: .pi * 2.0, clockwise: true)
        }
        pointsLayer.path = pointBezierPath.cgPath
        
        scrollLayer.addSublayer(chartLayer)
        scrollLayer.addSublayer(pointsLayer)
        view.layer.addSublayer(scrollLayer)
//        contentView.layer.addSublayer(chartLayer)
//        contentView.layer.addSublayer(pointsLayer)
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        let offset = sender.value * 3000
        scrollLayer.scroll(to: CGPoint(x: CGFloat(offset), y: 0))
    }

}

