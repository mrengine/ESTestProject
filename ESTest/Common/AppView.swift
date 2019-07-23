//
//  AppView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit
import RxSwift

protocol AppViewProtocol: class {
    func assemble()
}

class AppView: UIView, AppViewProtocol {

    private(set) var disposeBag: DisposeBag!

    override init(frame: CGRect) {
        super.init(frame: frame)
        disposeBag = DisposeBag()
        assemble()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        disposeBag = DisposeBag()
        assemble()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        disposeBag = nil
    }

    func assemble() { }
}
