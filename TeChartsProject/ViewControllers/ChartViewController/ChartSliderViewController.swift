//
//  ChartSliderViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

protocol ChartSliderViewControllerDelegate: class {
    
    func chartSliderViewController(_ controller: ChartSliderViewController,  changedMin min: Float, changedMax max: Float)
    
}


class ChartSliderViewController: UIViewController {

    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private var thumbView: UIView!
    
    private var maskLayer: CAShapeLayer!
    
    private var currentThumbOffset: CGFloat = 0
    private var fragment: Fragment? = nil
    private var minimumWidth: CGFloat = 0
    
    weak var delegate: ChartSliderViewControllerDelegate?
    
    var minValue: Float = 0
    var maxValue: Float = 0
    var thumbWidth: CGFloat = 1 / 6 {
        didSet { minimumWidth = thumbWidth * view.bounds.width }
    }
    
    
    var chart: Chart! {
        didSet { chartView?.chart = chart }
    }
    
    var colors: Colors!
    
    private lazy var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handler), userInfo: nil, repeats: true)
    private var poffset: CGFloat = 3
    
    @objc private func handler() {
//        DispatchQueue.global().async {
            if self.thumbView.frame.origin.x > self.chartView.bounds.width - self.thumbView.frame.width || self.thumbView.frame.origin.x <= 0 {
                self.poffset = -self.poffset
            }
//            DispatchQueue.main.async {
                self.thumbView.frame.origin.x += self.poffset
                self.updateMaskLayerPath()
                self.updateSelectedRangeValues()
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chart = chart
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.timer.fire()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFrames()
    }
    
    private func setup() {
        maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.opacity = 0.12
        view.layer.addSublayer(maskLayer)
        view.addSubview(thumbView)
    }
    
    private func updateFrames() {
        minimumWidth = thumbWidth * view.bounds.width
        maskLayer.frame = chartView.frame
        thumbView.frame = CGRect(x: 0, y: 0, width: minimumWidth, height: view.bounds.height)
        updateMaskLayerPath()
    }
    
    private func updateMaskLayerPath() {
        let path = UIBezierPath(
            roundedRect: maskLayer.bounds,
            cornerRadius: 0
        )
        var frame = thumbView.frame
        frame.size.height = chartView.bounds.height
        let holePath = UIBezierPath(
            roundedRect: frame,
            cornerRadius: 0
        )
        
        path.append(holePath)
        path.usesEvenOddFillRule = true
        maskLayer.path = path.cgPath
    }
    
    private func updateSelectedRangeValues() {
        minValue = Float(thumbView.frame.minX / view.bounds.width)
        maxValue = Float(thumbView.frame.maxX / view.bounds.width)
        delegate?.chartSliderViewController(self, changedMin: minValue, changedMax: maxValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let touchView = touch.view, touchView == thumbView {
            let point = touch.location(in: touchView)
            if point.x < 20 {
                fragment = .left
            } else if point.x > (thumbView.bounds.width - 20) {
                fragment = .right
            } else {
                fragment = .center
            }
            currentThumbOffset = fragment == .right ? thumbView.bounds.width - point.x : point.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentThumbOffset = 0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.view == thumbView else { return }
        let point = touch.location(in: view)
        let x = point.x + (fragment != .right ? -currentThumbOffset : currentThumbOffset)
        let correction = fragment != .right ? thumbView.bounds.width - 1 : 0
        
        guard x >= 0 && (x < (view.bounds.width - correction) || fragment == .left) else { return }
        
        if fragment == .left {
            thumbView.frame.size.width += (thumbView.frame.origin.x - x)
        } else if fragment == .right {
            thumbView.frame.size.width = x - thumbView.frame.origin.x
        }
        
        thumbView.frame.size.width = thumbView.frame.size.width < minimumWidth ? minimumWidth : thumbView.frame.size.width
        
        if fragment != .right && ((x + thumbView.frame.width) < view.bounds.width) {
            thumbView.frame.origin.x = x
        }
        updateMaskLayerPath()
        updateSelectedRangeValues()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentThumbOffset = 0
    }

}

extension ChartSliderViewController {
    
    enum Fragment {
        case left
        case center
        case right
    }
    
}
