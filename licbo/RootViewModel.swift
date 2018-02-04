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
    func search(for query: String)
}

class RootViewModel {
    
    private var productCache = Variable<[Product]>([])

    init() {

    }
}

extension RootViewModel: RootViewModelType {

    var products: Observable<[Product]> {
        return productCache.asObservable()
    }

    func search(for query: String) {
        LCBOAPINetworkManager.findProducts(with: query) { (products) in
            self.productCache.value = products
        }
    }
}
