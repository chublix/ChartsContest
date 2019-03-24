//
//  HistoryCollectionViewCell.swift
//  TeChartsProject
//
//  Created by Andriy Chuprina on 3/23/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    func setup(with item: HistoryItem) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        titleLabel.textColor = item.color
        valueLabel.textColor = item.color
    }

}
