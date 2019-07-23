//
//  DetailViewController.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

final class DetailViewController: AppViewController<DetailView, DetailViewModel> {

    override func bind() {
        guard let viewModel = self.viewModel else { return }
        snpView.scrollableView.bind(to: viewModel.user)
        snpView.subscriptionView.bind(to: viewModel.subscriptions)

        snpView.subscriptionView.selectedItem
            .subscribe(onNext: { subscription in
                self.snpView.scrollableView.updateSubscriptionInfo(by: subscription)
                self.snpView.informationView.updateSubscriptionInfo(by: subscription)
            })
            .disposed(by: disposeBag)
    }

}

