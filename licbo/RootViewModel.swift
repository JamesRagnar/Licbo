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
    var userLocation: Observable<CLLocationCoordinate2D?> { get }
    var stores: Observable<[Store]> { get }
}

class RootViewModel: NSObject {

    fileprivate lazy var locationManager = LocationManager()
    fileprivate lazy var disposeBag = DisposeBag()
    
    fileprivate var knownStores = Variable<[Store]>([])
    
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        locationManager.requestLocation()
        
        locationManager
            .userLocation
            .subscribe(onNext: { [weak self] (location) in
            if let location = location {
                self?.searchForStores(near: location)
            }
        }).disposed(by: disposeBag)
    }
    
    private func searchForStores(near location: CLLocationCoordinate2D) {
        NetworkManager.getStores(near: location, result: { [weak self] (stores) in
            self?.knownStores.value = stores
        })
    }
}

extension RootViewModel: RootViewModelType {
    
    var userLocation: Observable<CLLocationCoordinate2D?> {
        return locationManager.userLocation
    }
    
    var stores: Observable<[Store]> {
        return knownStores.asObservable()
    }
}
