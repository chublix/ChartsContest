//
//  XAxisCollectionViewDataSource.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/20/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class XAxisCollectionViewDataSource: NSObject {

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: "AxisTextCollectionViewCell", bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var titles: [String] = [] {
        didSet { collectionView?.reloadData() }
    }
    
    var colors: Colors? {
        didSet { collectionView?.reloadData() }
    }
    
}


extension XAxisCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
}


extension XAxisCollectionViewDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? AxisTextCollectionViewCell)?.setup(with: titles[indexPath.item], textColor: colors?.axisText, textAligment: .center)
    }
    
}


extension XAxisCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(titles.count)
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
