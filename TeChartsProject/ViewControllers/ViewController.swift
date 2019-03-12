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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


}

