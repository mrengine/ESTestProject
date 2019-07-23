//
//  ScrollablePage.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/23/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

protocol ScrollablePageProtocol: class {
    var user: User? { get }
    var subscription: Subscription? { get }
}

class ScrollablePage: AppView, ScrollablePageProtocol {

    var user: User?
    var subscription: Subscription?

    override func assemble() {
        backgroundColor = .clear
    }

}
