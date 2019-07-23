//
//  SubscriptionViewCell.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

final class SubscriptionViewCell: UICollectionViewCell, ReusableCell {

    private(set) var element: Subscription?

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    var hasSelected: Bool {
        set {
            tipsLabel.isHidden = !newValue
            selectingHeaderView.isHidden = !newValue
            selectingView.isHidden = !newValue
            daysLabel.textColor = !newValue ? .black : selectedColor
            periodLabel.textColor = !newValue ? .black : selectedColor
            priceLabel.textColor = !newValue ? .black : selectedColor
        }
        get {
            return !tipsLabel.isHidden
        }
    }

    private let selectedColor = UIColor.red

    private let tipsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()

    private let selectingHeaderView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    private let selectingView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.borderWidth = 7
        return view
    }()

    private let daysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    private let periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        assemble()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configurate(by element: Subscription) {
        self.element = element
        tipsLabel.text = element.tips
        daysLabel.text = element.days
        periodLabel.text = element.period
        priceLabel.text = element.price
    }

    private func assemble() {
        setup()
        addSubview(containerView)
        containerView.addSubview(selectingView)
        containerView.addSubview(selectingHeaderView)
        containerView.addSubview(tipsLabel)
        containerView.addSubview(daysLabel)
        containerView.addSubview(periodLabel)
        containerView.addSubview(priceLabel)
        setupLayout()
    }

    private func setup() {
        selectingView.layer.borderColor = selectedColor.cgColor
        selectingHeaderView.backgroundColor = selectedColor
    }

    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.bottom.equalToSuperview().offset(-2)
        }

        selectingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectingHeaderView.snp.makeConstraints { make in
            make.centerX.equalTo(tipsLabel)
            make.top.equalTo(tipsLabel.snp.top)
            make.width.equalTo(tipsLabel).offset(10)
            make.height.equalTo(20)
        }

        tipsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(snp.top).offset(-6)
            make.height.equalTo(20)
        }

        daysLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }

        periodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(daysLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }

        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(periodLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
    }


}
