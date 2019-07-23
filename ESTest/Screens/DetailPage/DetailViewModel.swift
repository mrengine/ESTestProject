//
//  DetailViewModel.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailViewModelProtocol: AppViewModelProtocol {
    var user: Observable<User> { get }
    var subscriptions: Observable<[Subscription]> { get }
}

struct DetailViewModel: DetailViewModelProtocol {

    let user: Observable<User>
    let subscriptions: Observable<[Subscription]>

    init() {
        user = fetchUser().asObservable()
        subscriptions = fetchSubscriptions().asObservable()
    }
}

private func fetchUser() -> Observable<User> {
    return Observable.create { observer in
        observer.onNext(User(phoneNumber: "+1 858-264-0510"))
        observer.onCompleted()
        return Disposables.create()
    }
}

private func fetchSubscriptions() -> Observable<[Subscription]> {
    return Observable.create { observer in
        observer.onNext([
            Subscription(days: "3",
                         period: "months",
                         price: "$29.99",
                         tips: "10% Discount",
                         description: "3 months $29.99, 10% discount"),
            Subscription(days: "3-Day",
                         period: "trial",
                         price: "$7.99/wk",
                         tips: "Most Popular",
                         description: "3 days free, then $7.99/wk, if not cancelled"),
            Subscription(days: "12",
                         period: "months",
                         price: "$59.99",
                         tips: "30% Discount",
                         description: "12 months $59.99, 30% discount")
        ])
        observer.onCompleted()
        return Disposables.create()
    }
}
