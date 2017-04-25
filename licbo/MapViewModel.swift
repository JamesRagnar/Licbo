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
import UIKit

protocol MapViewModelType {
    var storePins: Variable<[Store]> { get }
    var edgeInsets: Variable<UIEdgeInsets> { get }
    func fetchStores()
    func setMapPadding(_ insets: UIEdgeInsets)
    func storeAnnotationSelected(_ annotation: Store?)
    func storeAnnotationDeselected(_ annotation: Store?)
}

class MapViewModel: MapViewModelType {

    private lazy var cachedStores = Variable<[Store]>([])
    private lazy var locationManager = UserLocationManager()
    private lazy var disposeBag = DisposeBag()

    var storePins = Variable<[Store]>([])
    var edgeInsets = Variable<UIEdgeInsets>(.zero)

    private var selectedAnnotation: Store?

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

    func setMapPadding(_ insets: UIEdgeInsets) {
        edgeInsets.value = insets
    }

    private func queryStores(_ location: CLLocation?) {
        NetworkManager.getStores(withLocation: location) { [weak self] (stores) in
            self?.cachedStores.value = stores
            self?.storePins.value = stores
        }
    }

    func storeAnnotationSelected(_ annotation: Store?) {
        guard let store = annotation else {
            print("No selected Store data")
            return
        }
        if selectedAnnotation != nil {
            // Reset the known pins
            storePins.value = cachedStores.value
            selectedAnnotation = nil
        } else {
            // Zoom to store
            // Show directions from user if location available
            selectedAnnotation = store
            storePins.value = [store]
        }
    }

    func storeAnnotationDeselected(_ annotation: Store?) {
        selectedAnnotation = nil
        storePins.value = cachedStores.value
    }
}
