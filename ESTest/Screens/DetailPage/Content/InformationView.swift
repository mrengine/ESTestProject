//
//  InformationView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

final class InformationView: AppView {

    private let activateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ACTIVATE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()

    private let termsPrivacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms of Use | Privacy Policy", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    private let restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Restore", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "Information about the subscription:\nPayment will be...\nLine 3"
        return label
    }()

    override func assemble() {
        backgroundColor = .white
        addSubview(activateButton)
        addSubview(termsPrivacyButton)
        addSubview(restoreButton)
        addSubview(descriptionLabel)
        setupLayout()
        interactions()
    }

    func updateSubscriptionInfo(by subscription: Subscription?) {
        guard subscription != nil else {
            self.activateButton.isEnabled = false
            self.activateButton.alpha = 0.5
            return
        }
        activateButton.isEnabled = true
        activateButton.alpha = 1
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(250)
        }

        activateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 250, height: 50))
        }

        termsPrivacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activateButton.snp.bottom)
            make.height.equalTo(30)
        }

        restoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsPrivacyButton.snp.bottom)
            make.height.equalTo(30)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    private func interactions() {
        activateButton.rx.tap
            .subscribe(onNext: { phoneNumber in
                print("Activate current subscription")
            })
            .disposed(by: disposeBag)

        termsPrivacyButton.rx.tap
            .subscribe(onNext: { phoneNumber in
                print("Open Terms and Privacy Policy")
            })
            .disposed(by: disposeBag)

        restoreButton.rx.tap
            .subscribe(onNext: { phoneNumber in
                print("Restore")
            })
            .disposed(by: disposeBag)
    }

}
