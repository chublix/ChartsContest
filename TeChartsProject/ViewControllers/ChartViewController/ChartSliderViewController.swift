//
//  ChartSliderViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartSliderViewController: UIViewController {

    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private var thumbView: UIView!
    
//    private var leftThumbView: UIView!
//    private var rightThumbView: UIView!
    
    private var currentThumbView: UIView?
    private var currentThumbOffset: CGFloat = 0
    private var position: Position? = nil
    
    var value: Float = 0
    
    var chart: Chart! {
        didSet { chartView?.chartsData = chart }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.chartsData = chart
        setupThumbs()
    }
    
    private func setupThumbs() {
        view.addSubview(thumbView)
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = view.bounds
//        maskLayer.fillColor = UIColor.yellow.cgColor
        
        thumbView.frame = CGRect(x: 100, y: 0, width: 80, height: 44)
//        maskLayer.mask = thumbView.layer
//        chartView.layer.addSublayer(maskLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let touchView = touch.view, touchView == thumbView {
            let point = touch.location(in: touchView)
            if point.x < 24 {
                position = .left
            } else if point.x > (thumbView.bounds.width - 24) {
                position = .right
            } else {
                position = .center
            }
            currentThumbOffset = point.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentThumbView = nil
        currentThumbOffset = 0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.view == thumbView else { return }
        switch position {
            case .some(.left): break
            case .some(.right): break
            case .some(.center): break
            case .none: break
        }
        let point = touch.location(in: view)
        let x = point.x - currentThumbOffset
        currentThumbView?.frame.origin.x = x
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentThumbView = nil
        currentThumbOffset = 0
    }

}

extension ChartSliderViewController {
    
    enum Position {
        case left
        case center
        case right
    }
    
}
