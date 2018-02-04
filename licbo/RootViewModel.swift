//
//  RootViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

protocol RootViewModelType {
    var products: Observable<[Product]> { get }
}

class RootViewModel {
    
    private var productCache = Variable<[Product]>([])

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        LCBOAPINetworkManager.getProducts { (products) in
            self.productCache.value = products
        }
    }
}

extension RootViewModel: RootViewModelType {

    var products: Observable<[Product]> {
        return productCache.asObservable()
    }
}
