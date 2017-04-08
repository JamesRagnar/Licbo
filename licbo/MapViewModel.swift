//
//  MapViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

protocol MapViewModelType {
    var stores: Observable<[Store]> { get }
    func fetchStores()
}

class MapViewModel {
    
    private lazy var data = Variable<[Store]>([])

    var stores: Observable<[Store]> {
        return data.asObservable()
    }
    
    func fetchStores() {
        NetworkManager.getStores { [weak self] (items) in
            self?.data.value = items
        }
    }
}
