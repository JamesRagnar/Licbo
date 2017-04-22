//
//  ProductsViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import RxSwift
import UIKit

protocol ProductsViewModelType {
    var products: Variable<[Product]> { get }
    func fetchProducts()
    func selectProduct(_ product: Product, navigationController: UINavigationController?)
}

class ProductsViewModel: ProductsViewModelType {

    private lazy var imageManager = NetworkImageManager()

    var products: Variable<[Product]> = Variable<[Product]>([])

    func fetchProducts() {
        NetworkManager.getProducts { [weak self] (items) in
            for item in items {
                item.thumbnailObservable = self?.imageManager.imageObservableForURL(item.imageThumbnailUrlString)
            }
            self?.products.value = items
        }
    }

    func selectProduct(_ product: Product, navigationController: UINavigationController?) {
        product.imageObservable = imageManager.imageObservableForURL(product.imageUrlString)
        let productDetailViewController = ProductDetailViewController(product)
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
