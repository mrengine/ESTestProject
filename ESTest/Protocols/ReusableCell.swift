//
//  ReusableCell.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

protocol ReusableCell {
    @nonobjc static var reuseIdentifier: String { get }
}

extension ReusableCell {
    @nonobjc static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    func dequeueReusableCell<Cell: ReusableCell>(withType type: Cell.Type, forItemAt indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue reusable cell with \(Cell.reuseIdentifier) reuse identifier.")
        }

        return cell
    }
}
