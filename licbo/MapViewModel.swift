//
//  MapViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift
import MapKit
import CoreLocation

protocol MapViewModelType {
    var userLocation: Observable<CLLocationCoordinate2D?> { get }
    var storePins: Observable<[StoreMapPointAnnotation]> { get }
    func fetchStores()
    func storeAnnotationSelected(_ annotation: StoreMapPointAnnotation?, navigationController: UINavigationController?)
}

class MapViewModel: MapViewModelType {

    private lazy var cachedStores = Variable<[Store]>([])
    private lazy var locationManager = UserLocationManager()
    private lazy var disposeBag = DisposeBag()

    var storePins: Observable<[StoreMapPointAnnotation]> {
        return
            cachedStores
                .asObservable()
                .map({ (stores) -> [StoreMapPointAnnotation] in
                    var annotations = [StoreMapPointAnnotation]()
                    for store in stores {
                        if let annotation = StoreMapPointAnnotation(store) {
                            annotations.append(annotation)
                        }
                    }
                    return annotations
                })
    }
    
    var stores: Observable<[Store]> {
        return cachedStores.asObservable()
    }

    func fetchStores() {
        locationManager
            .location
            .subscribe(onNext: { [weak self] (location) in
                guard let location = location else {
                    return
                }
                print("query")
                self?.queryStores(location)
            }).disposed(by: disposeBag)

        locationManager.requestUserLocation()
    }

    var userLocation: Observable<CLLocationCoordinate2D?> {
        return locationManager
            .location
            .map({ (location) -> CLLocationCoordinate2D? in
                print("location")
                return location?.coordinate
            }).asObservable()
    }

    private func queryStores(_ location: CLLocation?) {
        NetworkManager.getStores(withLocation: location) { [weak self] (stores) in
            print("Stores")
            self?.cachedStores.value = stores
        }
    }

    func storeAnnotationSelected(_ annotation: StoreMapPointAnnotation?,
                                 navigationController: UINavigationController?) {
        guard let store = annotation?.store else {
            print("Bad store annotation data")
            return
        }
        let storeDetailViewController = StoreDetailViewController(store)
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}
