//
//  SubscriptionView.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit
import RxSwift

final class SubscriptionView: AppView {

    let selectedItem = PublishSubject<Subscription?>()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = .zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SubscriptionViewCell.self, forCellWithReuseIdentifier: SubscriptionViewCell.reuseIdentifier)
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .gray
        collectionView.clipsToBounds = false
        return collectionView
    }()

    private let rows: CGFloat = 3

    override func assemble() {
        collectionView.delegate = self
        addSubview(collectionView)
        setupLayout()
        interactions()
    }

    func bind(to data: Observable<[Subscription]>) {
        let bindData: (Int, Subscription, SubscriptionViewCell) -> Void = { (_, element, cell) in
            cell.configurate(by: element)
        }

        data
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: SubscriptionViewCell.reuseIdentifier, cellType: SubscriptionViewCell.self))(bindData)
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(160)
        }

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func interactions() {
        collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? SubscriptionViewCell else { return }
                for index in 0...self.collectionView.numberOfItems(inSection: 0) where index != indexPath.row {
                    let indexPath = IndexPath(item: index, section: 0)
                    let item = self.collectionView.cellForItem(at: indexPath) as? SubscriptionViewCell
                    item?.hasSelected = false
                }
                cell.hasSelected = !cell.hasSelected
                self.selectedItem.onNext(cell.hasSelected ? cell.element : nil)
            })
            .disposed(by: disposeBag)
    }

}

extension SubscriptionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width / rows, height: bounds.height)
    }
}
