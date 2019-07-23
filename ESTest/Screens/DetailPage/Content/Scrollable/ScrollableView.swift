//
//  ScrollableView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit
import RxSwift

final class ScrollableView: AppView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .green
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let pageContol: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.5)
        control.currentPageIndicatorTintColor = .white
        return control
    }()
    
    override func assemble() {
        backgroundColor = .clear
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        addSubview(pageContol)
        setupLayout()
        push(pages: makePages())
        interactions()
    }

    func bind(to user: Observable<User>) {
        user
            .subscribe(onNext: { user in
                self.stackView.arrangedSubviews.forEach { ($0 as? ScrollablePage)?.user = user }
            })
            .disposed(by: disposeBag)
    }

    func updateSubscriptionInfo(by subscription: Subscription?) {
        stackView.arrangedSubviews.forEach { ($0 as? ScrollablePage)?.subscription = subscription }
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(Environment.isPhoneXSeries ? 420 : 400)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView.snp.height)
        }

        pageContol.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }

    private func makePages() -> [ScrollablePage] {
        let pages = [
            ScrollableMainView(),
            ScrollableCustomView(withColor: .red),
            ScrollableCustomView(withColor: .green),
            ScrollableCustomView(withColor: .yellow)
        ]
        pageContol.numberOfPages = pages.count
        return pages
    }

    private func push(pages: [ScrollablePage]) {
        pages.forEach { page in
            stackView.addArrangedSubview(page)
            page.snp.makeConstraints { make in
                make.width.equalTo(scrollView.snp.width)
            }
        }
    }

    private func interactions() {
        scrollView.rx.didScroll
            .map { _ -> CGFloat in return self.scrollView.contentOffset.x }
            .map { offset -> Int in return Int(offset / self.scrollView.bounds.width) }
            .distinctUntilChanged()
            .subscribe(onNext: { page in
                self.pageContol.currentPage = page
            })
            .disposed(by: disposeBag)
    }

}
