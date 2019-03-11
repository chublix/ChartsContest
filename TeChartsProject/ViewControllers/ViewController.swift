//
//  ViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit
import ChartLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let chartView = ChartView(frame: CGRect(x: 15, y: 50, width: 375, height: 280))
        chartView.backgroundColor = UIColor(hex: 0xfafafa)
        view.addSubview(chartView)
    }


}

