//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

class RootViewController: BaseViewController {

    private let viewModel: RootViewModelType

    private lazy var imageCache = ImageManager()

    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewFlowLayout()
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds,
                                              collectionViewLayout: self.layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "ProductCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .gray
        return collectionView
    }()

    private lazy var products = [ProductModelType]()

    init(viewModel: RootViewModelType) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.addSubview(collectionView)
    }

    override func viewDidLoad() {

        viewModel
            .products
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (productUpdates) in
                self?.products = productUpdates
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension RootViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell else {
            fatalError()
        }

        let product = products[indexPath.row]
        cell.imageCache = imageCache
        cell.bind(product)

        return cell
    }
}

extension RootViewController: UICollectionViewDelegate {

}

extension RootViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 300)
    }
}
