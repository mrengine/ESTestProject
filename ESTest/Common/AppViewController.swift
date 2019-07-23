//
//  AppViewController.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AppViewController<T: UIView, M: AppViewModelProtocol>: UIViewController {

    let disposeBag = DisposeBag()
    var snpView: T {
        guard storyboard == nil else {
            fatalError("Using storyboard doesn't support T as Snapkit view.")
        }
        return view as! T
    }

    override func loadView() {
        super.loadView()
        guard storyboard == nil else { return }
        view = T(frame: view.bounds)
    }

    var viewModel: M? {
        didSet {
            bind()
        }
    }

    func bind() { }
}
