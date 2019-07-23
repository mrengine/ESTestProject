//
//  DetailView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

final class DetailView: AppView {

    let scrollableView = ScrollableView()
    let subscriptionView = SubscriptionView()
    let informationView = InformationView()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layoutMargins = .zero
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override func assemble() {
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(scrollableView)
        stackView.addArrangedSubview(subscriptionView)
        stackView.addArrangedSubview(informationView)

        setupLayout()
        interactions()
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }

    private func interactions() {
        scrollView.rx.didScroll
            .map { _ -> CGFloat in return self.scrollView.contentOffset.y }
            .subscribe(onNext: { currentOffsetY in
                self.scrollView.bounces = currentOffsetY > 100
            })
            .disposed(by: disposeBag)
    }

}
