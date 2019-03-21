//
//  ChartsView.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/21/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartsView: UIView {

    var chartsData: [ChartColumn] = [] {
        didSet {
            update()
        }
    }
    
    override var frame: CGRect {
        didSet {
            update()
        }
    }
    
    private var chartsSublayers: [CAShapeLayer]? {
        get { return layer.sublayers as? [CAShapeLayer] }
        set { layer.sublayers = newValue }
    }
    
    private func update() {
        
    }
    
}
