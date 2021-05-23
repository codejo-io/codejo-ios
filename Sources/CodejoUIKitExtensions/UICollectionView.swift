//
//  UICollectionView.swift
//  Codejo
//
//  Created by Cole James on 10/23/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit

extension UICollectionView {

    var closestCellIndex: Int {
        var desiredScrollViewXPos = Float(self.contentOffset.x)

        if UIScreen.main.traitCollection.horizontalSizeClass == .compact {
            desiredScrollViewXPos += Float(self.bounds.size.width / 2)
        }

        var closestCellIndex = -1

        var closestDistance: Float = .greatestFiniteMagnitude

        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]

            var desiredCellXPos = Float(cell.frame.origin.x)

            if UIScreen.main.traitCollection.horizontalSizeClass == .compact {
                desiredCellXPos +=  Float(cell.bounds.size.width / 2)
            }

            // Now calculate closest cell
            let distance: Float = fabsf(desiredScrollViewXPos - desiredCellXPos)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }

        return closestCellIndex
    }

    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = .normal

        let closestCellIndex = self.closestCellIndex

        if closestCellIndex != -1, let cell = cellForItem(at: IndexPath(row: closestCellIndex, section: 0)) {
            scrollToItem(at: closestCellIndex, cellSize: cell.frame.size, animated: true)
        }
    }

    func scrollToItem(at index: Int, cellSize: CGSize, animated: Bool) {
        if UIScreen.main.traitCollection.horizontalSizeClass != .compact {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            let xOffset = (CGFloat(cellSize.width) + layout.minimumInteritemSpacing) * CGFloat(index)
            setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
        } else {
            scrollToItem(at: IndexPath(row: index, section: 0), at:  .centeredHorizontally, animated: animated)
        }
    }

}
