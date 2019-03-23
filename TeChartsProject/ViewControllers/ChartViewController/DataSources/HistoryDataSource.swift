//
//  HistoryDataSource.swift
//  TeChartsProject
//
//  Created by Elena Chekhova on 3/23/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

struct HistoryItem {
    let title: String
    let value: String
    let color: UIColor
}

class HistoryDataSource: NSObject {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: "HistoryCollectionViewCell", bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var items: [HistoryItem] = [] {
        didSet { collectionView?.reloadData() }
    }
    
    var contentWidth: CGFloat {
        return items.map { getWidth(for: $0) }.reduce(0, +) + CGFloat(6 * (items.count - 1))
    }
    
    private func getWidth(for item: HistoryItem) -> CGFloat {
        let height = collectionView.bounds.height / 2
        let titleRect = (item.title as NSString).boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: height),
            options: [/*.usesLineFragmentOrigin,*/ .usesFontLeading],
            attributes: [ .font: UIFont.systemFont(ofSize: 10) ],
            context: nil
        )
        let valueRect = (item.value as NSString).boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: height),
            options: [/*.usesLineFragmentOrigin,*/ .usesFontLeading],
            attributes: [ .font: UIFont.systemFont(ofSize: 12) ],
            context: nil
        )
        return max(titleRect.width, valueRect.width) + 6
    }
    
}


extension HistoryDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
}


extension HistoryDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? HistoryCollectionViewCell)?.setup(with: items[indexPath.item])
    }
    
}


extension HistoryDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = getWidth(for: items[indexPath.item])
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
}
