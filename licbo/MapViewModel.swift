//
//  MapViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

protocol MapViewModelType {
    var userLocation: Observable<CLLocationCoordinate2D?> { get }
    var stores: Observable<[Store]> { get }
    func fetchStores()
}

class MapViewModel {

    private lazy var data = Variable<[Store]>([])
    private lazy var locationManager = UserLocationManager()
    private lazy var disposeBag = DisposeBag()

    var stores: Observable<[Store]> {
        return data.asObservable()
    }

    func fetchStores() {
        locationManager
            .location
            .subscribe(onNext: { [weak self] (location) in
                guard let location = location else {
                    return
                }
                self?.queryStores(location)
            }).disposed(by: disposeBag)

        locationManager.requestUserLocation()
    }

    var userLocation: Observable<CLLocationCoordinate2D?> {
        return locationManager
            .location
            .map({ (location) -> CLLocationCoordinate2D? in
                return location?.coordinate
            }).asObservable()
    }

    private func queryStores(_ location: CLLocation?) {
        NetworkManager.getStores(withLocation: location) { [weak self] (stores) in
            self?.data.value = stores
        }
    }
}
