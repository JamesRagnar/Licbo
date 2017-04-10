//
//  ProductsViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import RxSwift

protocol ProductsViewModelType {
    var products: Observable<[Product]> { get }
    func fetchProducts()
    func selectProduct(_ product: Product)
}

class ProductsViewModel: ProductsViewModelType {

    private lazy var data = Variable<[Product]>([])

    var products: Observable<[Product]> {
        return data.asObservable()
    }

    func fetchProducts() {
        NetworkManager.getProducts { [weak self] (items) in
            self?.data.value = items
        }
    }

    func selectProduct(_ product: Product) {

    }
}
