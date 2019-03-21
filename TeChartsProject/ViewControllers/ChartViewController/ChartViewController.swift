//
//  ChartViewController.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/20/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet private weak var xAxisCollectionView: UICollectionView!
    @IBOutlet private weak var yAxisCollectionView: UICollectionView!
    
    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var xAxisDataSource: XAxisCollectionViewDataSource!
    @IBOutlet private weak var yAxisDataSource: YAxisCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xAxisDataSource.titles = ["feb 4", "feb 7", "feb 10", "feb 13"]
        yAxisDataSource.titles = ["0", "10", "20", "30", "40", "50"].reversed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backgroundLayer = BackgroundLayer()
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        backgroundLayer.linesColor = UIColor.lightGray
        backgroundLayer.linesCount = 6
        backgroundLayer.frame = contentView.frame
        contentView.layer.addSublayer(backgroundLayer)
    }

}
