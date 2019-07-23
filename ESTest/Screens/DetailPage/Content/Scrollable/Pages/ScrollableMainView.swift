//
//  ScrollableMainView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/23/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

final class ScrollableMainView: ScrollablePage {

    override var user: User? {
        didSet {
            updateUser(by: user)
        }
    }

    override var subscription: Subscription? {
        didSet {
            updateSubscription(by: subscription)
        }
    }

    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Real Number"
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Contact anyone with your real number"
        return label
    }()

    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        return button
    }()

    let subscriptionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()

    override func assemble() {
        super.assemble()
        backgroundColor = .blue
        addSubview(phoneNumberLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(callButton)
        addSubview(subscriptionDescriptionLabel)
        setupLayout()
        interactions()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        callButton.layer.cornerRadius = callButton.frame.height / 2
    }

    private func setupLayout() {
        phoneNumberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Environment.isPhoneXSeries ? 45 : 30)
            make.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(20)
            make.height.equalTo(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.height.equalTo(20)
        }

        callButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 70, height: 70))
        }

        subscriptionDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo(CGSize(width: 140, height: 30))
        }
    }

    private func interactions() {
        callButton.rx.tap
            .subscribe(onNext: { phoneNumber in
                guard let phoneNumber = self.phoneNumberLabel.text else { return }
                print("Calling \(phoneNumber)")
            })
            .disposed(by: disposeBag)
    }

    private func updateUser(by user: User?) {
        guard let user = user else { fatalError("User is empty") }
        phoneNumberLabel.text = user.phoneNumber
    }

    private func updateSubscription(by subscription: Subscription?) {
        subscriptionDescriptionLabel.text = subscription?.description
    }

}
