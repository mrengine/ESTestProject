//
//  Environment.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/23/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

struct Environment {

    static var isPhoneXSeries: Bool {
        return UIApplication.shared.statusBarFrame.height >= CGFloat(44)
    }

}
