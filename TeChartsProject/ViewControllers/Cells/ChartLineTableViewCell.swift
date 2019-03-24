//
//  ChartLineTableViewCell.swift
//  TeChartsProject
//
//  Created by Elena Chekhova on 3/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class ChartLineTableViewCell: UITableViewCell {

    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.layer.cornerRadius = 4
    }
    
    func setup(with line: Line) {
        indicatorView.backgroundColor = line.color
        titleLabel.text = line.name
        accessoryType = line.enabled ? .checkmark : .none
    }
    
}
