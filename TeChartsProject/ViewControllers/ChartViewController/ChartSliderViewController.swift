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
    
    private var currentThumbOffset: CGFloat = 0
    private var fragment: Fragment? = nil
    
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
        thumbView.frame = CGRect(x: 100, y: 0, width: 80, height: 44)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if let touchView = touch.view, touchView == thumbView {
            let point = touch.location(in: touchView)
            if point.x < 24 {
                fragment = .left
            } else if point.x > (thumbView.bounds.width - 24) {
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
        let correction = fragment != .right ? thumbView.bounds.width : 0
        guard x >= 0 && x <= (view.bounds.width - correction) else {
            return
        }
        
        if fragment == .left {
            thumbView.frame.size.width += (thumbView.frame.origin.x - x)
        } else if fragment == .right {
            let step = x - thumbView.frame.origin.x
            thumbView.frame.size.width = step
        }
        
        thumbView.frame.size.width = thumbView.frame.size.width < 80 ? 80 : thumbView.frame.size.width
        
        if fragment != .right {
            thumbView.frame.origin.x = x
        }
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
