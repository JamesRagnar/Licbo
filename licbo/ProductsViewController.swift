//
//  ProductsViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: BaseViewController {

    fileprivate struct Constants {
        static let cellIdentifier = "productCell"
    }

    fileprivate lazy var productsViewModel = ProductsViewModel()
    fileprivate lazy var products = [Product]()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        productsViewModel
            .products
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { (products) in
            self.products = products
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)

        productsViewModel.fetchProducts()
    }
}

extension ProductsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier,
                                                            for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Fucked cell ya dummy"   )
        }
        cell.update(with: products[indexPath.row])
        return cell
    }
}
