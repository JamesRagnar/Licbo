//
//  UserLocationManager.swift
//  licbo
//
//  Created by James Harquail on 2017-04-09.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import RxSwift
import RxCocoa

protocol UserLocationManagerType {
    var location: Observable<CLLocation?> { get }
    func requestUserLocation()
}

class UserLocationManager: UserLocationManagerType {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    /*
     *  authorized
     *
     *  Discussion:
     *      Returns true if the user has granted whenInUser or authorizedAlways
     *      Returns false if the user has denied permission, or is unable to give permission
     *      Returns nil if the user has not been asked for authorization permission
     */
    private func authorized() -> Bool? {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            return true
        case .notDetermined:
            return nil
        default:
            return false
        }
    }
    
    private lazy var disposeBag = DisposeBag()
    
    init() {
        locationManager
            .rx
            .didChangeAuthorizationStatus
            .subscribe(onNext: { [weak self] (authStatus) in
                guard let authorized = self?.authorized() else {
                    return
                }
                print("Ping")
                if authorized {
                    self?.locationManager.requestLocation()
                }
        }).disposed(by: disposeBag)
        
        locationManager
            .rx
            .didFailWithError
            .subscribe(onNext: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func requestUserLocation() {
        guard let authorized = authorized() else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if authorized {
            locationManager.requestLocation()
        }
    }
    
    var location: Observable<CLLocation?> {
        return locationManager
            .rx
            .didUpdateLocations
            .startWith([])
            .map { (locations) -> CLLocation? in
                return locations.first
            }.asObservable()
    }
}
