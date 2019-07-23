//
//  ScrollableCustomView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/23/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

final class ScrollableCustomView: ScrollablePage {

    init(withColor color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
