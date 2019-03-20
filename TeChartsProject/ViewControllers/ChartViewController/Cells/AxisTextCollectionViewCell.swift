//
//  AxisTextCollectionViewCell.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/20/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class AxisTextCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    func setup(with title: String, textAligment: NSTextAlignment = .left) {
        titleLabel.textAlignment = textAligment
        titleLabel.text = title
    }
    
}
